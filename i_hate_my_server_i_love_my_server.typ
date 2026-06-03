= I hate my server, I love my server

The web and mail servers are working and functioning but not to my
standards.

It's my first attempt at using OpenLDAP as identity management to manage
infrastructure such as DNS records, email recipients, service/host to
person authentication, group management and more. How I designed it
works well for the most part and integrates well.

But it is not implemented well.

== Problems & Solution
Here are a few problems and flaws with my implementation that require a
solution.

=== Shell Scripting
It sucks. I don't get why people like to write in shell. The OpenLDAP
scripts are riddled with eval making it hard to read with shell escapes
everywhere, how data is transformed into environment variables is just a
poor excuse for bad mapping support.

On the contrary, the benefits of interpreted languages, such as Python,
offer more functionality, readability and speed.

I plan to create a new branch that converts the bash scripts to python.

=== Person-only Email / Mailing Lists
Only persons are allowed to send and receive emails.

Not sure whether this is a script problem or a server configuration
problem. But needs sorting for any diagnostics that hosts/services may
send.

Mailing lists are planned to be implemented too.

=== Missing OpenLDAP attributes
There are a few desirable OpenLDAP attributes not implemented, such as
ExternalDomain, DNS records such as SRV or CNAME and memberof based
attributes for Hosts/Services so emails can be read across different
objectClass.

At the moment the OpenLDAP server isn't fully configured anyway and it's
barebones.

I plan to update the schema and configure it properly.

=== DNS server
The current server is dnsmasq which is designed to be  a DNS forwarder.
An alternative such as BIND 9 from Internet Systems Consortium would be
more sensible.

dnsmasq can still be used for internal DHCP tasks.

=== Hardware
Currently the server is hogging a laptop. Hardly benefiting from it's
resources.

Raspberry PI I have got lying around would make more sense.

== What I like at the moment
- The server's external IP is routed through a wireguard server that
is hosted via TOR.

- My data is point-to-point encrypted with my own generated SSL/TLS
certificate. Meaning the data is safe from any MITM attacks. Notably
email meaning all ingoing email is encrypted before reaching my server,
for outgoing, GPG signatures and encryption fits my needs well.

- The domain nameservers are hosted on the server itself.

- This blog

Let's get to work!
