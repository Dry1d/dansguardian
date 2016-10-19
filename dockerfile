FROM debian
MAINTAINER Dry1d Dry1d@hotmail.com

ADD resolv.conf /etc/resolv.conf
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Asia/Yekaterinburg /etc/localtime
RUN apt-get update -q
RUN apt-get install -qy dansguardian squid3 clamav-daemon
RUN apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/

RUN mkdir /var/run/clamav
RUN touch /var/run/clamav/clamd.ctl
RUN chown clamav:clamav /var/run/clamav/clamd.ctl

RUN /etc/init.d/dansguardian stop
RUN /etc/init.d/squid3 stop

ADD squid.conf /etc/squid3/squid.conf

ADD dansguardian.conf /etc/dansguardian/dansguardian.conf

ADD BL /etc/dansguardian/lists/blacklists/

RUN freshclam
ADD exceptioniplist /etc/dansguardian/lists/exceptioniplist
ADD run /files/run
RUN chmod +x /files/run
EXPOSE 8081

CMD /files/run
