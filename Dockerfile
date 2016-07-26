FROM adelton/freeipa-client:fedora-24

MAINTAINER Nathan Kinder & Jon Richter

# Install Ipsilon packages
RUN dnf install -y ipsilon ipsilon-authgssapi mod_ssl && dnf clean all

# Install FreeIPA admin tools to allow a us to get a keytab
RUN dnf install -y freeipa-admintools && dnf clean all

# Add a script to configure and start ipsilon
ADD ipsilon-server-configure-first /usr/sbin/ipsilon-server-configure-first
RUN chmod -v +x /usr/sbin/ipsilon-server-configure-first

EXPOSE 80 443

ENTRYPOINT /usr/sbin/ipsilon-server-configure-first
