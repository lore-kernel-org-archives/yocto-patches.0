Return-Path: <rybczynska@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BC2CAC5B9
	for <webhook@archiver.kernel.org>; Tue, 30 Sep 2025 04:21:17 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.17670.1759206071552405708
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 29 Sep 2025 21:21:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=BnuLS8q+;
 spf=pass (domain: gmail.com, ip: 209.85.210.182, mailfrom: rybczynska@gmail.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7841da939deso1902256b3a.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 29 Sep 2025 21:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759206071; x=1759810871; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Of8ucVayP9DGNj5pQERSo16D/UHfZjafMR3swfz5QQE=;
        b=BnuLS8q+f0R1/6SPvYjLBXH+oVcLSMU4LhptKmM38BkzXWaofr/BZpfInHIARjsXnm
         soIib8vjQLa9TtgVBfo7z1ES8koFpxdkPXTYo1GgiEzn4YmA6sTY95s7PU3EwgF38NGl
         ye1ROPZPGMBtRgW3yaaiYG9hy0BNbOhXY50gWtc+qMX4bSMFhBKvRLESoAjqadwhd+OH
         c34YvhjxSImkJm3rdNrj+5+tmCjSfUXyblz3QsPibWZVgegb6z8UhryuNqcEusHBagEp
         nK6A+xtTYt7VQYO+SfgAy/X7wBNmePHMlcg/GpUrUrU/gGYOciGObrIcY5QPFOXQ4qe5
         IiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759206071; x=1759810871;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Of8ucVayP9DGNj5pQERSo16D/UHfZjafMR3swfz5QQE=;
        b=M2beIMYOkggQZG1SHT/zGG0Wd8eW/FoYMXjBC7sekD3HdJQFrFxKaxb4eMzQoI01rw
         5+aWqKeilA2sy5RFzjoI8TA9HNpX/6HuQG80y8HGt3z2vvb6r1CT9WvaSjFs+7x5LO3U
         M0Dak7D2FDwx0NIEvCrEG0h26BKqJPGoa0Mxz1zfWeW9C9i5hLeHk8wFXH8oap5eltp8
         i05lf9btm8W0CG2C1UyXvL+Pq+ytM+CZUCz/2Ok3aytoGkPy9IL5TtkI0uNY1F1yETKs
         udqJfZyBl/7N6xQG0MgsyEdfLeq1WKTCxyRdkVpJh5UZ+niCcM1qo31oT9ZSLW532XFU
         QJAw==
X-Gm-Message-State: AOJu0YwU62/BErI/RPLgZngLGuC6bkHJukrqZ1KVkip2c/DxLrYPeTr8
	U72apkhBUddi9LjAQm5V7gck4eqMG/whW0q2QdIjZeGRNbqXb2u6zWBX1VgQoWE6ggAtgbNahGs
	OOxf+iOD7h+RYqTicrrFB7uLpIqWlGGjwBw==
X-Gm-Gg: ASbGncskOf65tGER9D2wet2g9Jhd+YmW3ifvrG89mI4+lmmhW8MR+x1uJpbbfZP8Z3R
	+82Nt7XWN5RH+O4RBmPsTp7KC+kSuv4nq81jI1zgg09ooYVGq5+R7UgAAtC2uZ1BLP+aA2/gQl7
	mcGuUuGA6nzlwOLBcJls5FtFiM/MK2GyEfb5bnG61gGdK5qjqbQ/MNMHWNZ8z29tBlvCqFVHpib
	6tQYjpjUY+C720Eol52T+tAazo8kVS1Zi7hRsr4S9vJC/6mrgSGtoylUvqMLt1VQYrdV97XpaER
	OVB5B5Mwng/t8H5zcQ==
X-Google-Smtp-Source: AGHT+IEaR+QdJPhc8jRCLRRhOsSfBtK4BvHbrRr4Zl10PH3nv4cqoZoMM04kqy7u4KqsaxaSV5MSBa7XtgcaWBQmz6I=
X-Received: by 2002:a17:902:ce01:b0:271:479d:3ddc with SMTP id
 d9443c01a7336-27ed4a1a371mr208853715ad.15.1759206070638; Mon, 29 Sep 2025
 21:21:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250921130714.415502-1-yi.zhao@windriver.com>
In-Reply-To: <20250921130714.415502-1-yi.zhao@windriver.com>
From: Marta Rybczynska <rybczynska@gmail.com>
Date: Tue, 30 Sep 2025 06:20:58 +0200
X-Gm-Features: AS18NWA2rpwmXD6Ga0wBtpr7J0GDW0wNVEZB4yLezajWjS9rrtLLyoqutLKn6mA
Message-ID: <CAApg2=TzOA9Rf7EeQNoKgt2_77qxJYLaxGe5aZh0v47KHQx+EQ@mail.gmail.com>
Subject: Re: [meta-security][PATCH] python3-fail2ban: update to latest git rev
To: Yi Zhao <yi.zhao@windriver.com>
Cc: yocto-patches@lists.yoctoproject.org, scott.murray@konsulko.com
Content-Type: multipart/alternative; boundary="000000000000ed5b7e063ffd14ae"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 30 Sep 2025 04:21:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2261

--000000000000ed5b7e063ffd14ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,
Thank you for the patch, adding it to testing.

Kind regards,
Marta

On Sun, Sep 21, 2025 at 3:07=E2=80=AFPM Yi Zhao <yi.zhao@windriver.com> wro=
te:

> Update to latest git rev as the current version doesn't work with
> OpenSSH 9.8+[1].
>
> Ptest result:
> $ ptest-runner python3-fail2ban
> START: ptest-runner
> 2025-09-21T12:45
> BEGIN: /usr/lib64/python3-fail2ban/ptest
>
> Ran 538 tests in 13.045s
> OK (skipped=3D3)
> DURATION: 14
> END: /usr/lib64/python3-fail2ban/ptest
> 2025-09-21T12:46
> STOP: ptest-runner
> TOTAL: 1 FAIL: 0
>
> [1]
> https://github.com/fail2ban/fail2ban/commit/2fed408c05ac5206b490368d94599=
869bd6a056d
>
> Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> ---
>  ...ges-the-IPs-again.-additionally-it-g.patch | 210 ------------------
>  ...case.py-set-correct-config-dir-for-t.patch |  35 ---
>  .../fail2ban/python3-fail2ban_git.bb          |   4 +-
>  3 files changed, 1 insertion(+), 248 deletions(-)
>  delete mode 100644
> dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.c=
om-changes-the-IPs-again.-additionally-it-g.patch
>  delete mode 100644
> dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientrea=
dertestcase.py-set-correct-config-dir-for-t.patch
>
> diff --git
> a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example=
.com-changes-the-IPs-again.-additionally-it-g.patch
> b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example=
.com-changes-the-IPs-again.-additionally-it-g.patch
> deleted file mode 100644
> index 73014ab..0000000
> ---
> a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example=
.com-changes-the-IPs-again.-additionally-it-g.patch
> +++ /dev/null
> @@ -1,210 +0,0 @@
> -From 5b6c13f0aae79a23d94570bacd1b5796e57f088d Mon Sep 17 00:00:00 2001
> -From: sebres <info@sebres.de>
> -Date: Thu, 30 Jan 2025 01:05:30 +0100
> -Subject: [PATCH] example.com changes the IPs, again... additionally it
> got
> - more IPs, which look unstable now (depends on resolver), so replaced wi=
th
> - fail2ban.org, that seems to resolve to single IPv4 and IPv6 (can be
> adjusted
> - later for something more persistent)
> -
> -
> -Upstream-Status: Backport
> -[
> https://github.com/fail2ban/fail2ban/commit/5b6c13f0aae79a23d94570bacd1b5=
796e57f088d
> ]
> -
> -Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> ----
> - .../tests/files/logs/apache-fakegooglebot     |  6 +-
> - fail2ban/tests/files/testcase-usedns.log      |  4 +-
> - fail2ban/tests/filtertestcase.py              | 58 +++++++++----------
> - fail2ban/tests/utils.py                       |  4 +-
> - 4 files changed, 36 insertions(+), 36 deletions(-)
> -
> -diff --git a/fail2ban/tests/files/logs/apache-fakegooglebot
> b/fail2ban/tests/files/logs/apache-fakegooglebot
> -index b77a1a6b..024842fd 100644
> ---- a/fail2ban/tests/files/logs/apache-fakegooglebot
> -+++ b/fail2ban/tests/files/logs/apache-fakegooglebot
> -@@ -1,5 +1,5 @@
> - # Apache 2.2
> - # failJSON: { "time": "2015-01-31T14:29:44", "match": true, "host":
> "66.249.66.1" }
> --66.249.66.1 - - - [31/Jan/2015:14:29:44 ] example.com "GET / HTTP/1.1"
> 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +
> http://www.google.com/bot.html)" + 293 1149 546
> --# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host":
> "93.184.215.14" }
> --93.184.215.14 - - - [31/Jan/2015:14:29:44 ] example.com "GET /
> HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
> -+66.249.66.1 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET / HTTP/1.1"
> 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +
> http://www.google.com/bot.html)" + 293 1149 546
> -+# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host":
> "51.159.55.100" }
> -+51.159.55.100 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET /
> HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
> -diff --git a/fail2ban/tests/files/testcase-usedns.log
> b/fail2ban/tests/files/testcase-usedns.log
> -index eea6eb44..3e7b36bb 100644
> ---- a/fail2ban/tests/files/testcase-usedns.log
> -+++ b/fail2ban/tests/files/testcase-usedns.log
> -@@ -1,2 +1,2 @@
> --Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from
> example.com port 51332 ssh2
> --Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from
> ::ffff:93.184.215.14 port 51332 ssh2
> -+Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from
> fail2ban.org port 51332 ssh2
> -+Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from
> ::ffff:51.159.55.100 port 51332 ssh2
> -diff --git a/fail2ban/tests/filtertestcase.py
> b/fail2ban/tests/filtertestcase.py
> -index 20945b78..26961a1b 100644
> ---- a/fail2ban/tests/filtertestcase.py
> -+++ b/fail2ban/tests/filtertestcase.py
> -@@ -587,14 +587,14 @@ class IgnoreIP(LogCaptureTestCase):
> -                               self.assertNotLogged("returned
> successfully")
> -
> -       def testIgnoreCauseOK(self):
> --              ip =3D "93.184.215.14"
> -+              ip =3D "51.159.55.100"
> -               for ignore_source in ["dns", "ip", "command"]:
> -                       self.filter.logIgnoreIp(ip, True,
> ignore_source=3Dignore_source)
> -                       self.assertLogged("[%s] Ignore %s by %s" % (
> self.jail.name, ip, ignore_source))
> -
> -       def testIgnoreCauseNOK(self):
> --              self.filter.logIgnoreIp("example.com", False,
> ignore_source=3D"NOT_LOGGED")
> --              self.assertNotLogged("[%s] Ignore %s by %s" % (
> self.jail.name, "example.com", "NOT_LOGGED"))
> -+              self.filter.logIgnoreIp("fail2ban.org", False,
> ignore_source=3D"NOT_LOGGED")
> -+              self.assertNotLogged("[%s] Ignore %s by %s" % (
> self.jail.name, "fail2ban.org", "NOT_LOGGED"))
> -
> -
> - class IgnoreIPDNS(LogCaptureTestCase):
> -@@ -607,7 +607,7 @@ class IgnoreIPDNS(LogCaptureTestCase):
> -               self.filter =3D FileFilter(self.jail)
> -
> -       def testIgnoreIPDNS(self):
> --              for dns in ("www.epfl.ch", "example.com"):
> -+              for dns in ("www.epfl.ch", "fail2ban.org"):
> -                       self.filter.addIgnoreIP(dns)
> -                       ips =3D DNSUtils.dnsToIp(dns)
> -                       self.assertTrue(len(ips) > 0)
> -@@ -1892,22 +1892,22 @@ class GetFailures(LogCaptureTestCase):
> -               #unittest.F2B.SkipIfNoNetwork() ## without network it is
> simulated via cache in utils.
> -               # We should still catch failures with usedns =3D no ;-)
> -               output_yes =3D (
> --                      ('93.184.215.14', 1, 1124013299.0,
> --                        ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed
> publickey for roehl from example.com port 51332 ssh2']
> -+                      ('51.159.55.100', 1, 1124013299.0,
> -+                        ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed
> publickey for roehl from fail2ban.org port 51332 ssh2']
> -                       ),
> --                      ('93.184.215.14', 1, 1124013539.0,
> --                        ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed
> publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
> -+                      ('51.159.55.100', 1, 1124013539.0,
> -+                        ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed
> publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
> -                       ),
> --                      ('2606:2800:21f:cb07:6820:80da:af6b:8b2c', 1,
> 1124013299.0,
> --                        ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed
> publickey for roehl from example.com port 51332 ssh2']
> -+                      ('2001:bc8:1200:6:208:a2ff:fe0c:61f8', 1,
> 1124013299.0,
> -+                        ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed
> publickey for roehl from fail2ban.org port 51332 ssh2']
> -                       ),
> -               )
> -               if not unittest.F2B.no_network and not
> DNSUtils.IPv6IsAllowed():
> -                       output_yes =3D output_yes[0:2]
> -
> -               output_no =3D (
> --                      ('93.184.215.14', 1, 1124013539.0,
> --                        ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed
> publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
> -+                      ('51.159.55.100', 1, 1124013539.0,
> -+                        ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed
> publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
> -                       )
> -               )
> -
> -@@ -2098,10 +2098,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
> -               super(DNSUtilsNetworkTests, self).setUp()
> -               #unittest.F2B.SkipIfNoNetwork()
> -
> --      ## example.com IPs considering IPv6 support (without network it
> is simulated via cache in utils).
> -+      ## fail2ban.org IPs considering IPv6 support (without network it
> is simulated via cache in utils).
> -       EXAMPLE_ADDRS =3D (
> --              ['93.184.215.14',
> '2606:2800:21f:cb07:6820:80da:af6b:8b2c'] if unittest.F2B.no_network or
> DNSUtils.IPv6IsAllowed() else \
> --              ['93.184.215.14']
> -+              ['51.159.55.100', '2001:bc8:1200:6:208:a2ff:fe0c:61f8'] i=
f
> unittest.F2B.no_network or DNSUtils.IPv6IsAllowed() else \
> -+              ['51.159.55.100']
> -       )
> -
> -       def test_IPAddr(self):
> -@@ -2163,13 +2163,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
> -               self.assertTrue(r < ip6)
> -
> -       def testUseDns(self):
> --              res =3D DNSUtils.textToIp('www.example.com', 'no')
> -+              res =3D DNSUtils.textToIp('www.fail2ban.org', 'no')
> -               self.assertSortedEqual(res, [])
> -               #unittest.F2B.SkipIfNoNetwork() ## without network it is
> simulated via cache in utils.
> --              res =3D DNSUtils.textToIp('www.example.com', 'warn')
> -+              res =3D DNSUtils.textToIp('www.fail2ban.org', 'warn')
> -               # sort ipaddr, IPv4 is always smaller as IPv6
> -               self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
> --              res =3D DNSUtils.textToIp('www.example.com', 'yes')
> -+              res =3D DNSUtils.textToIp('www.fail2ban.org', 'yes')
> -               # sort ipaddr, IPv4 is always smaller as IPv6
> -               self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
> -
> -@@ -2177,13 +2177,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
> -               #unittest.F2B.SkipIfNoNetwork() ## without network it is
> simulated via cache in utils.
> -               # Test hostnames
> -               hostnames =3D [
> --                      'www.example.com',
> -+                      'www.fail2ban.org',
> -                       'doh1.2.3.4.buga.xxxxx.yyy.invalid',
> -                       '1.2.3.4.buga.xxxxx.yyy.invalid',
> -                       ]
> -               for s in hostnames:
> -                       res =3D DNSUtils.textToIp(s, 'yes')
> --                      if s =3D=3D 'www.example.com':
> -+                      if s =3D=3D 'www.fail2ban.org':
> -                               # sort ipaddr, IPv4 is always smaller as
> IPv6
> -                               self.assertSortedEqual(res,
> self.EXAMPLE_ADDRS)
> -                       else:
> -@@ -2234,8 +2234,8 @@ class DNSUtilsNetworkTests(unittest.TestCase):
> -
> -               self.assertEqual(IPAddr('192.0.2.0').getPTR(),
> '0.2.0.192.in-addr.arpa.')
> -               self.assertEqual(IPAddr('192.0.2.1').getPTR(),
> '1.2.0.192.in-addr.arpa.')
> --
> self.assertEqual(IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c').getPTR(=
),
> --
> 'c.2.b.8.b.6.f.a.a.d.0.8.0.2.8.6.7.0.b.c.f.1.2.0.0.0.8.2.6.0.6.2.ip6.arpa=
.')
> -+              self.assertEqual(IPAddr('2001:db8::1').getPTR(),
> -+
> '1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa=
.')
> -
> -       def testIPAddr_Equal6(self):
> -               self.assertEqual(
> -@@ -2365,10 +2365,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
> -
> -       def testIPAddr_CompareDNS(self):
> -               #unittest.F2B.SkipIfNoNetwork() ## without network it is
> simulated via cache in utils.
> --              ips =3D IPAddr('example.com')
> --              self.assertTrue(IPAddr("93.184.215.14").isInNet(ips))
> --
> self.assertEqual(IPAddr("2606:2800:21f:cb07:6820:80da:af6b:8b2c").isInNet=
(ips),
> --
> "2606:2800:21f:cb07:6820:80da:af6b:8b2c" in self.EXAMPLE_ADDRS)
> -+              ips =3D IPAddr('fail2ban.org')
> -+              self.assertTrue(IPAddr("51.159.55.100").isInNet(ips))
> -+
> self.assertEqual(IPAddr("2001:bc8:1200:6:208:a2ff:fe0c:61f8").isInNet(ips=
),
> -+
> "2001:bc8:1200:6:208:a2ff:fe0c:61f8" in self.EXAMPLE_ADDRS)
> -
> -       def testIPAddr_wrongDNS_IP(self):
> -               unittest.F2B.SkipIfNoNetwork()
> -@@ -2376,11 +2376,11 @@ class DNSUtilsNetworkTests(unittest.TestCase):
> -               DNSUtils.ipToName('*')
> -
> -       def testIPAddr_Cached(self):
> --              ips =3D [DNSUtils.dnsToIp('example.com'), DNSUtils.dnsToI=
p('
> example.com')]
> -+              ips =3D [DNSUtils.dnsToIp('fail2ban.org'),
> DNSUtils.dnsToIp('fail2ban.org')]
> -               for ip1, ip2 in zip(ips, ips):
> -                       self.assertEqual(id(ip1), id(ip2))
> --              ip1 =3D IPAddr('93.184.215.14'); ip2 =3D
> IPAddr('93.184.215.14'); self.assertEqual(id(ip1), id(ip2))
> --              ip1 =3D IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c');
> ip2 =3D IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c');
> self.assertEqual(id(ip1), id(ip2))
> -+              ip1 =3D IPAddr('51.159.55.100'); ip2 =3D
> IPAddr('51.159.55.100'); self.assertEqual(id(ip1), id(ip2))
> -+              ip1 =3D IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); ip2=
 =3D
> IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); self.assertEqual(id(ip1),
> id(ip2))
> -
> -       def test_NetworkInterfacesAddrs(self):
> -               for withMask in (False, True):
> -diff --git a/fail2ban/tests/utils.py b/fail2ban/tests/utils.py
> -index f71ba60a..e6ef54f3 100644
> ---- a/fail2ban/tests/utils.py
> -+++ b/fail2ban/tests/utils.py
> -@@ -326,8 +326,8 @@ def initTests(opts):
> -                       ('failed.dns.ch', set()),
> -                       ('doh1.2.3.4.buga.xxxxx.yyy.invalid', set()),
> -                       ('1.2.3.4.buga.xxxxx.yyy.invalid', set()),
> --                      ('example.com',
> set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'),
> IPAddr('93.184.215.14')])),
> --                      ('www.example.com',
> set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'),
> IPAddr('93.184.215.14')])),
> -+                      ('fail2ban.org',
> set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'),
> IPAddr('51.159.55.100')])),
> -+                      ('www.fail2ban.org',
> set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'),
> IPAddr('51.159.55.100')])),
> -               ):
> -                       c.set(*i)
> -               # if fast - precache all host names as localhost addresse=
s
> (speed-up getSelfIPs/ignoreself):
> ---
> -2.34.1
> -
> diff --git
> a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientr=
eadertestcase.py-set-correct-config-dir-for-t.patch
> b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientr=
eadertestcase.py-set-correct-config-dir-for-t.patch
> deleted file mode 100644
> index a60b0fd..0000000
> ---
> a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientr=
eadertestcase.py-set-correct-config-dir-for-t.patch
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -From 9f26da3cf854e48b7939c2a9baa0cb3ffbee5994 Mon Sep 17 00:00:00 2001
> -From: Yi Zhao <yi.zhao@windriver.com>
> -Date: Thu, 11 Sep 2025 22:36:07 +0800
> -Subject: [PATCH] clientreadertestcase.py: set correct config dir for
> - testReadStockJailFilterComplete
> -
> -In test case testReadStockJailFilterComplete, set configuration
> -directory to CONFIG_DIR (/etc/fail2ban/filter.d on the target) instead
> -of the hardcoded "config" directory. Otherwise, the config files will
> -not be found during runtime testing.
> -
> -Upstream-Status: Backport
> -[
> https://github.com/fail2ban/fail2ban/commit/9f26da3cf854e48b7939c2a9baa0c=
b3ffbee5994
> ]
> -
> -Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
> ----
> - fail2ban/tests/clientreadertestcase.py | 2 +-
> - 1 file changed, 1 insertion(+), 1 deletion(-)
> -
> -diff --git a/fail2ban/tests/clientreadertestcase.py
> b/fail2ban/tests/clientreadertestcase.py
> -index e6a2806c..b8ebbbc7 100644
> ---- a/fail2ban/tests/clientreadertestcase.py
> -+++ b/fail2ban/tests/clientreadertestcase.py
> -@@ -878,7 +878,7 @@ class JailsReaderTest(LogCaptureTestCase):
> -               self.assertTrue(jails.getOptions())       # reads fine
> -               # grab all filter names
> -               filters =3D set(os.path.splitext(os.path.split(a)[1])[0]
> --                      for a in glob.glob(os.path.join('config',
> 'filter.d', '*.conf'))
> -+                      for a in glob.glob(os.path.join(CONFIG_DIR,
> 'filter.d', '*.conf'))
> -                               if not (a.endswith('common.conf') or
> a.endswith('-aggressive.conf')))
> -               # get filters of all jails (filter names without options
> inside filter[...])
> -               filters_jail =3D set(
> ---
> -2.34.1
> -
> diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/
> python3-fail2ban_git.bb
> b/dynamic-layers/meta-python/recipes-security/fail2ban/
> python3-fail2ban_git.bb
> index b0b65de..c85953a 100644
> --- a/dynamic-layers/meta-python/recipes-security/fail2ban/
> python3-fail2ban_git.bb
> +++ b/dynamic-layers/meta-python/recipes-security/fail2ban/
> python3-fail2ban_git.bb
> @@ -11,10 +11,8 @@ LIC_FILES_CHKSUM =3D
> "file://COPYING;md5=3Decabc31e90311da843753ba772885d9f"
>
>  DEPENDS =3D "python3-native"
>
> -SRCREV =3D "ac62658c10f492911f8a0037a0bcf97c8521cd78"
> +SRCREV =3D "2856092709470250dc299931bc748f112590059f"
>  SRC_URI =3D "git://
> github.com/fail2ban/fail2ban.git;branch=3Dmaster;protocol=3Dhttps \
> -
>  file://0001-example.com-changes-the-IPs-again.-additionally-it-g.patch \
> -
>  file://0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch \
>             file://initd \
>             file://run-ptest \
>             "
> --
> 2.34.1
>
>

--000000000000ed5b7e063ffd14ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div>Thank you for the patch, adding it t=
o testing.</div><div><br></div><div>Kind regards,</div><div>Marta<br></div>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Sun, Sep 21, 2025 at 3:07=E2=80=AFPM Yi Zhao &lt;<=
a href=3D"mailto:yi.zhao@windriver.com">yi.zhao@windriver.com</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Update to late=
st git rev as the current version doesn&#39;t work with<br>
OpenSSH 9.8+[1].<br>
<br>
Ptest result:<br>
$ ptest-runner python3-fail2ban<br>
START: ptest-runner<br>
2025-09-21T12:45<br>
BEGIN: /usr/lib64/python3-fail2ban/ptest<br>
<br>
Ran 538 tests in 13.045s<br>
OK (skipped=3D3)<br>
DURATION: 14<br>
END: /usr/lib64/python3-fail2ban/ptest<br>
2025-09-21T12:46<br>
STOP: ptest-runner<br>
TOTAL: 1 FAIL: 0<br>
<br>
[1] <a href=3D"https://github.com/fail2ban/fail2ban/commit/2fed408c05ac5206=
b490368d94599869bd6a056d" rel=3D"noreferrer" target=3D"_blank">https://gith=
ub.com/fail2ban/fail2ban/commit/2fed408c05ac5206b490368d94599869bd6a056d</a=
><br>
<br>
Signed-off-by: Yi Zhao &lt;<a href=3D"mailto:yi.zhao@windriver.com" target=
=3D"_blank">yi.zhao@windriver.com</a>&gt;<br>
---<br>
=C2=A0...ges-the-IPs-again.-additionally-it-g.patch | 210 -----------------=
-<br>
=C2=A0...case.py-set-correct-config-dir-for-t.patch |=C2=A0 35 ---<br>
=C2=A0.../fail2ban/<a href=3D"http://python3-fail2ban_git.bb" rel=3D"norefe=
rrer" target=3D"_blank">python3-fail2ban_git.bb</a>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A04 +-<br>
=C2=A03 files changed, 1 insertion(+), 248 deletions(-)<br>
=C2=A0delete mode 100644 dynamic-layers/meta-python/recipes-security/fail2b=
an/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch<br=
>
=C2=A0delete mode 100644 dynamic-layers/meta-python/recipes-security/fail2b=
an/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch<br=
>
<br>
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/000=
1-example.com-changes-the-IPs-again.-additionally-it-g.patch b/dynamic-laye=
rs/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the=
-IPs-again.-additionally-it-g.patch<br>
deleted file mode 100644<br>
index 73014ab..0000000<br>
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-examp=
le.com-changes-the-IPs-again.-additionally-it-g.patch<br>
+++ /dev/null<br>
@@ -1,210 +0,0 @@<br>
-From 5b6c13f0aae79a23d94570bacd1b5796e57f088d Mon Sep 17 00:00:00 2001<br>
-From: sebres &lt;<a href=3D"mailto:info@sebres.de" target=3D"_blank">info@=
sebres.de</a>&gt;<br>
-Date: Thu, 30 Jan 2025 01:05:30 +0100<br>
-Subject: [PATCH] <a href=3D"http://example.com" rel=3D"noreferrer" target=
=3D"_blank">example.com</a> changes the IPs, again... additionally it got<b=
r>
- more IPs, which look unstable now (depends on resolver), so replaced with=
<br>
- <a href=3D"http://fail2ban.org" rel=3D"noreferrer" target=3D"_blank">fail=
2ban.org</a>, that seems to resolve to single IPv4 and IPv6 (can be adjuste=
d<br>
- later for something more persistent)<br>
-<br>
-<br>
-Upstream-Status: Backport<br>
-[<a href=3D"https://github.com/fail2ban/fail2ban/commit/5b6c13f0aae79a23d9=
4570bacd1b5796e57f088d" rel=3D"noreferrer" target=3D"_blank">https://github=
.com/fail2ban/fail2ban/commit/5b6c13f0aae79a23d94570bacd1b5796e57f088d</a>]=
<br>
-<br>
-Signed-off-by: Yi Zhao &lt;<a href=3D"mailto:yi.zhao@windriver.com" target=
=3D"_blank">yi.zhao@windriver.com</a>&gt;<br>
----<br>
- .../tests/files/logs/apache-fakegooglebot=C2=A0 =C2=A0 =C2=A0|=C2=A0 6 +-=
<br>
- fail2ban/tests/files/testcase-usedns.log=C2=A0 =C2=A0 =C2=A0 |=C2=A0 4 +-=
<br>
- fail2ban/tests/filtertestcase.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 | 58 +++++++++----------<br>
- fail2ban/tests/utils.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 +-<br>
- 4 files changed, 36 insertions(+), 36 deletions(-)<br>
-<br>
-diff --git a/fail2ban/tests/files/logs/apache-fakegooglebot b/fail2ban/tes=
ts/files/logs/apache-fakegooglebot<br>
-index b77a1a6b..024842fd 100644<br>
---- a/fail2ban/tests/files/logs/apache-fakegooglebot<br>
-+++ b/fail2ban/tests/files/logs/apache-fakegooglebot<br>
-@@ -1,5 +1,5 @@<br>
- # Apache 2.2<br>
- # failJSON: { &quot;time&quot;: &quot;2015-01-31T14:29:44&quot;, &quot;ma=
tch&quot;: true, &quot;host&quot;: &quot;66.249.66.1&quot; }<br>
--66.249.66.1 - - - [31/Jan/2015:14:29:44 ] <a href=3D"http://example.com" =
rel=3D"noreferrer" target=3D"_blank">example.com</a> &quot;GET / HTTP/1.1&q=
uot; 200 814 &quot;-&quot; &quot;Mozilla/5.0 (compatible; Googlebot/2.1; +<=
a href=3D"http://www.google.com/bot.html" rel=3D"noreferrer" target=3D"_bla=
nk">http://www.google.com/bot.html</a>)&quot; + 293 1149 546<br>
--# failJSON: { &quot;time&quot;: &quot;2015-01-31T14:29:44&quot;, &quot;ma=
tch&quot;: false, &quot;host&quot;: &quot;93.184.215.14&quot; }<br>
--93.184.215.14 - - - [31/Jan/2015:14:29:44 ] <a href=3D"http://example.com=
" rel=3D"noreferrer" target=3D"_blank">example.com</a> &quot;GET / HTTP/1.1=
&quot; 200 814 &quot;-&quot; &quot;NOT A __GOOGLE_BOT__&quot; + 293 1149 54=
6<br>
-+66.249.66.1 - - - [31/Jan/2015:14:29:44 ] <a href=3D"http://fail2ban.org"=
 rel=3D"noreferrer" target=3D"_blank">fail2ban.org</a> &quot;GET / HTTP/1.1=
&quot; 200 814 &quot;-&quot; &quot;Mozilla/5.0 (compatible; Googlebot/2.1; =
+<a href=3D"http://www.google.com/bot.html" rel=3D"noreferrer" target=3D"_b=
lank">http://www.google.com/bot.html</a>)&quot; + 293 1149 546<br>
-+# failJSON: { &quot;time&quot;: &quot;2015-01-31T14:29:44&quot;, &quot;ma=
tch&quot;: false, &quot;host&quot;: &quot;51.159.55.100&quot; }<br>
-+51.159.55.100 - - - [31/Jan/2015:14:29:44 ] <a href=3D"http://fail2ban.or=
g" rel=3D"noreferrer" target=3D"_blank">fail2ban.org</a> &quot;GET / HTTP/1=
.1&quot; 200 814 &quot;-&quot; &quot;NOT A __GOOGLE_BOT__&quot; + 293 1149 =
546<br>
-diff --git a/fail2ban/tests/files/testcase-usedns.log b/fail2ban/tests/fil=
es/testcase-usedns.log<br>
-index eea6eb44..3e7b36bb 100644<br>
---- a/fail2ban/tests/files/testcase-usedns.log<br>
-+++ b/fail2ban/tests/files/testcase-usedns.log<br>
-@@ -1,2 +1,2 @@<br>
--Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from <a h=
ref=3D"http://example.com" rel=3D"noreferrer" target=3D"_blank">example.com=
</a> port 51332 ssh2<br>
--Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ff=
ff:93.184.215.14 port 51332 ssh2<br>
-+Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from <a h=
ref=3D"http://fail2ban.org" rel=3D"noreferrer" target=3D"_blank">fail2ban.o=
rg</a> port 51332 ssh2<br>
-+Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ff=
ff:51.159.55.100 port 51332 ssh2<br>
-diff --git a/fail2ban/tests/filtertestcase.py b/fail2ban/tests/filtertestc=
ase.py<br>
-index 20945b78..26961a1b 100644<br>
---- a/fail2ban/tests/filtertestcase.py<br>
-+++ b/fail2ban/tests/filtertestcase.py<br>
-@@ -587,14 +587,14 @@ class IgnoreIP(LogCaptureTestCase):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertNotLogged(&quot;returned s=
uccessfully&quot;)<br>
- <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0def testIgnoreCauseOK(self):<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip =3D &quot;93.184.215.=
14&quot;<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip =3D &quot;51.159.55.1=
00&quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for ignore_source i=
n [&quot;dns&quot;, &quot;ip&quot;, &quot;command&quot;]:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0self.filter.logIgnoreIp(ip, True, ignore_source=3Dignore_source)<=
br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0self.assertLogged(&quot;[%s] Ignore %s by %s&quot; % (<a href=3D"=
http://self.jail.name" rel=3D"noreferrer" target=3D"_blank">self.jail.name<=
/a>, ip, ignore_source))<br>
- <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0def testIgnoreCauseNOK(self):<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.filter.logIgnoreIp(=
&quot;<a href=3D"http://example.com" rel=3D"noreferrer" target=3D"_blank">e=
xample.com</a>&quot;, False, ignore_source=3D&quot;NOT_LOGGED&quot;)<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertNotLogged(&qu=
ot;[%s] Ignore %s by %s&quot; % (<a href=3D"http://self.jail.name" rel=3D"n=
oreferrer" target=3D"_blank">self.jail.name</a>, &quot;<a href=3D"http://ex=
ample.com" rel=3D"noreferrer" target=3D"_blank">example.com</a>&quot;, &quo=
t;NOT_LOGGED&quot;))<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.filter.logIgnoreIp(=
&quot;<a href=3D"http://fail2ban.org" rel=3D"noreferrer" target=3D"_blank">=
fail2ban.org</a>&quot;, False, ignore_source=3D&quot;NOT_LOGGED&quot;)<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertNotLogged(&qu=
ot;[%s] Ignore %s by %s&quot; % (<a href=3D"http://self.jail.name" rel=3D"n=
oreferrer" target=3D"_blank">self.jail.name</a>, &quot;<a href=3D"http://fa=
il2ban.org" rel=3D"noreferrer" target=3D"_blank">fail2ban.org</a>&quot;, &q=
uot;NOT_LOGGED&quot;))<br>
- <br>
- <br>
- class IgnoreIPDNS(LogCaptureTestCase):<br>
-@@ -607,7 +607,7 @@ class IgnoreIPDNS(LogCaptureTestCase):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.filter =3D Fil=
eFilter(self.jail)<br>
- <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0def testIgnoreIPDNS(self):<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for dns in (&quot;<a hre=
f=3D"http://www.epfl.ch" rel=3D"noreferrer" target=3D"_blank">www.epfl.ch</=
a>&quot;, &quot;<a href=3D"http://example.com" rel=3D"noreferrer" target=3D=
"_blank">example.com</a>&quot;):<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for dns in (&quot;<a hre=
f=3D"http://www.epfl.ch" rel=3D"noreferrer" target=3D"_blank">www.epfl.ch</=
a>&quot;, &quot;<a href=3D"http://fail2ban.org" rel=3D"noreferrer" target=
=3D"_blank">fail2ban.org</a>&quot;):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0self.filter.addIgnoreIP(dns)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ips =3D DNSUtils.dnsToIp(dns)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0self.assertTrue(len(ips) &gt; 0)<br>
-@@ -1892,22 +1892,22 @@ class GetFailures(LogCaptureTestCase):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#unittest.F2B.SkipI=
fNoNetwork() ## without network it is simulated via cache in utils.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# We should still c=
atch failures with usedns =3D no ;-)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output_yes =3D (<br=
>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (&#39;93.184.215.14&#39;, 1, 1124013299.0,<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [&#39;Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for =
roehl from <a href=3D"http://example.com" rel=3D"noreferrer" target=3D"_bla=
nk">example.com</a> port 51332 ssh2&#39;]<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (&#39;51.159.55.100&#39;, 1, 1124013299.0,<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [&#39;Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for =
roehl from <a href=3D"http://fail2ban.org" rel=3D"noreferrer" target=3D"_bl=
ank">fail2ban.org</a> port 51332 ssh2&#39;]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0),<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (&#39;93.184.215.14&#39;, 1, 1124013539.0,<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [&#39;Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for =
roehl from ::ffff:93.184.215.14 port 51332 ssh2&#39;]<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (&#39;51.159.55.100&#39;, 1, 1124013539.0,<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [&#39;Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for =
roehl from ::ffff:51.159.55.100 port 51332 ssh2&#39;]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0),<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (&#39;2606:2800:21f:cb07:6820:80da:af6b:8b2c&#39;, 1, 1124013299.0,<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [&#39;Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for =
roehl from <a href=3D"http://example.com" rel=3D"noreferrer" target=3D"_bla=
nk">example.com</a> port 51332 ssh2&#39;]<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (&#39;2001:bc8:1200:6:208:a2ff:fe0c:61f8&#39;, 1, 1124013299.0,<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [&#39;Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for =
roehl from <a href=3D"http://fail2ban.org" rel=3D"noreferrer" target=3D"_bl=
ank">fail2ban.org</a> port 51332 ssh2&#39;]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not unittest.F2B=
.no_network and not DNSUtils.IPv6IsAllowed():<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0output_yes =3D output_yes[0:2]<br>
- <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0output_no =3D (<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (&#39;93.184.215.14&#39;, 1, 1124013539.0,<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [&#39;Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for =
roehl from ::ffff:93.184.215.14 port 51332 ssh2&#39;]<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (&#39;51.159.55.100&#39;, 1, 1124013539.0,<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 [&#39;Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for =
roehl from ::ffff:51.159.55.100 port 51332 ssh2&#39;]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
- <br>
-@@ -2098,10 +2098,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0super(DNSUtilsNetwo=
rkTests, self).setUp()<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#unittest.F2B.SkipI=
fNoNetwork()<br>
- <br>
--=C2=A0 =C2=A0 =C2=A0 ## <a href=3D"http://example.com" rel=3D"noreferrer"=
 target=3D"_blank">example.com</a> IPs considering IPv6 support (without ne=
twork it is simulated via cache in utils).<br>
-+=C2=A0 =C2=A0 =C2=A0 ## <a href=3D"http://fail2ban.org" rel=3D"noreferrer=
" target=3D"_blank">fail2ban.org</a> IPs considering IPv6 support (without =
network it is simulated via cache in utils).<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0EXAMPLE_ADDRS =3D (<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [&#39;93.184.215.14&#39;=
, &#39;2606:2800:21f:cb07:6820:80da:af6b:8b2c&#39;] if unittest.F2B.no_netw=
ork or DNSUtils.IPv6IsAllowed() else \<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [&#39;93.184.215.14&#39;=
]<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [&#39;51.159.55.100&#39;=
, &#39;2001:bc8:1200:6:208:a2ff:fe0c:61f8&#39;] if unittest.F2B.no_network =
or DNSUtils.IPv6IsAllowed() else \<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [&#39;51.159.55.100&#39;=
]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0)<br>
- <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0def test_IPAddr(self):<br>
-@@ -2163,13 +2163,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(r &=
lt; ip6)<br>
- <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0def testUseDns(self):<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D DNSUtils.textToI=
p(&#39;<a href=3D"http://www.example.com" rel=3D"noreferrer" target=3D"_bla=
nk">www.example.com</a>&#39;, &#39;no&#39;)<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D DNSUtils.textToI=
p(&#39;<a href=3D"http://www.fail2ban.org" rel=3D"noreferrer" target=3D"_bl=
ank">www.fail2ban.org</a>&#39;, &#39;no&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertSortedEq=
ual(res, [])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#unittest.F2B.SkipI=
fNoNetwork() ## without network it is simulated via cache in utils.<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D DNSUtils.textToI=
p(&#39;<a href=3D"http://www.example.com" rel=3D"noreferrer" target=3D"_bla=
nk">www.example.com</a>&#39;, &#39;warn&#39;)<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D DNSUtils.textToI=
p(&#39;<a href=3D"http://www.fail2ban.org" rel=3D"noreferrer" target=3D"_bl=
ank">www.fail2ban.org</a>&#39;, &#39;warn&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# sort ipaddr, IPv4=
 is always smaller as IPv6<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertSortedEq=
ual(res, self.EXAMPLE_ADDRS)<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D DNSUtils.textToI=
p(&#39;<a href=3D"http://www.example.com" rel=3D"noreferrer" target=3D"_bla=
nk">www.example.com</a>&#39;, &#39;yes&#39;)<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 res =3D DNSUtils.textToI=
p(&#39;<a href=3D"http://www.fail2ban.org" rel=3D"noreferrer" target=3D"_bl=
ank">www.fail2ban.org</a>&#39;, &#39;yes&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# sort ipaddr, IPv4=
 is always smaller as IPv6<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertSortedEq=
ual(res, self.EXAMPLE_ADDRS)<br>
- <br>
-@@ -2177,13 +2177,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#unittest.F2B.SkipI=
fNoNetwork() ## without network it is simulated via cache in utils.<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# Test hostnames<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hostnames =3D [<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;<a href=3D"http://www.example.com" rel=3D"noreferrer" target=3D"_b=
lank">www.example.com</a>&#39;,<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;<a href=3D"http://www.fail2ban.org" rel=3D"noreferrer" target=3D"_=
blank">www.fail2ban.org</a>&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&#39;doh1.2.3.4.buga.xxxxx.yyy.invalid&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&#39;1.2.3.4.buga.xxxxx.yyy.invalid&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for s in hostnames:=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0res =3D DNSUtils.textToIp(s, &#39;yes&#39;)<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if s =3D=3D &#39;<a href=3D"http://www.example.com" rel=3D"noreferrer" =
target=3D"_blank">www.example.com</a>&#39;:<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if s =3D=3D &#39;<a href=3D"http://www.fail2ban.org" rel=3D"noreferrer"=
 target=3D"_blank">www.fail2ban.org</a>&#39;:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# sort ipaddr, IPv4 is always smaller=
 as IPv6<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertSortedEqual(res, self.EXAM=
PLE_ADDRS)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0else:<br>
-@@ -2234,8 +2234,8 @@ class DNSUtilsNetworkTests(unittest.TestCase):<br>
- <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(IP=
Addr(&#39;192.0.2.0&#39;).getPTR(), &#39;0.2.0.192.in-addr.arpa.&#39;)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(IP=
Addr(&#39;192.0.2.1&#39;).getPTR(), &#39;1.2.0.192.in-addr.arpa.&#39;)<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(IPAddr(=
&#39;2606:2800:21f:cb07:6820:80da:af6b:8b2c&#39;).getPTR(), <br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;c.2.b.8.b.6.f.a.a.d.0.8.0.2.8.6.7.0.b.c.f.1.2.0.0.0.8.2.6.0.6.2.ip=
6.arpa.&#39;)<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(IPAddr(=
&#39;2001:db8::1&#39;).getPTR(), <br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &#39;1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip=
6.arpa.&#39;)<br>
- <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0def testIPAddr_Equal6(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertEqual(<b=
r>
-@@ -2365,10 +2365,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):<br>
- <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0def testIPAddr_CompareDNS(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0#unittest.F2B.SkipI=
fNoNetwork() ## without network it is simulated via cache in utils.<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ips =3D IPAddr(&#39;<a h=
ref=3D"http://example.com" rel=3D"noreferrer" target=3D"_blank">example.com=
</a>&#39;)<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(IPAddr(&=
quot;93.184.215.14&quot;).isInNet(ips))<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(IPAddr(=
&quot;2606:2800:21f:cb07:6820:80da:af6b:8b2c&quot;).isInNet(ips),<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;2606:2800=
:21f:cb07:6820:80da:af6b:8b2c&quot; in self.EXAMPLE_ADDRS)<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ips =3D IPAddr(&#39;<a h=
ref=3D"http://fail2ban.org" rel=3D"noreferrer" target=3D"_blank">fail2ban.o=
rg</a>&#39;)<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertTrue(IPAddr(&=
quot;51.159.55.100&quot;).isInNet(ips))<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.assertEqual(IPAddr(=
&quot;2001:bc8:1200:6:208:a2ff:fe0c:61f8&quot;).isInNet(ips),<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;2001:bc8:=
1200:6:208:a2ff:fe0c:61f8&quot; in self.EXAMPLE_ADDRS)<br>
- <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0def testIPAddr_wrongDNS_IP(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unittest.F2B.SkipIf=
NoNetwork()<br>
-@@ -2376,11 +2376,11 @@ class DNSUtilsNetworkTests(unittest.TestCase):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DNSUtils.ipToName(&=
#39;*&#39;)<br>
- <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0def testIPAddr_Cached(self):<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ips =3D [DNSUtils.dnsToI=
p(&#39;<a href=3D"http://example.com" rel=3D"noreferrer" target=3D"_blank">=
example.com</a>&#39;), DNSUtils.dnsToIp(&#39;<a href=3D"http://example.com"=
 rel=3D"noreferrer" target=3D"_blank">example.com</a>&#39;)]<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ips =3D [DNSUtils.dnsToI=
p(&#39;<a href=3D"http://fail2ban.org" rel=3D"noreferrer" target=3D"_blank"=
>fail2ban.org</a>&#39;), DNSUtils.dnsToIp(&#39;<a href=3D"http://fail2ban.o=
rg" rel=3D"noreferrer" target=3D"_blank">fail2ban.org</a>&#39;)]<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for ip1, ip2 in zip=
(ips, ips):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0self.assertEqual(id(ip1), id(ip2))<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip1 =3D IPAddr(&#39;93.1=
84.215.14&#39;); ip2 =3D IPAddr(&#39;93.184.215.14&#39;); self.assertEqual(=
id(ip1), id(ip2))<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip1 =3D IPAddr(&#39;2606=
:2800:21f:cb07:6820:80da:af6b:8b2c&#39;); ip2 =3D IPAddr(&#39;2606:2800:21f=
:cb07:6820:80da:af6b:8b2c&#39;); self.assertEqual(id(ip1), id(ip2))<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip1 =3D IPAddr(&#39;51.1=
59.55.100&#39;); ip2 =3D IPAddr(&#39;51.159.55.100&#39;); self.assertEqual(=
id(ip1), id(ip2))<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ip1 =3D IPAddr(&#39;2001=
:bc8:1200:6:208:a2ff:fe0c:61f8&#39;); ip2 =3D IPAddr(&#39;2001:bc8:1200:6:2=
08:a2ff:fe0c:61f8&#39;); self.assertEqual(id(ip1), id(ip2))<br>
- <br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0def test_NetworkInterfacesAddrs(self):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for withMask in (Fa=
lse, True):<br>
-diff --git a/fail2ban/tests/utils.py b/fail2ban/tests/utils.py<br>
-index f71ba60a..e6ef54f3 100644<br>
---- a/fail2ban/tests/utils.py<br>
-+++ b/fail2ban/tests/utils.py<br>
-@@ -326,8 +326,8 @@ def initTests(opts):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(&#39;<a href=3D"http://failed.dns.ch" rel=3D"noreferrer" target=
=3D"_blank">failed.dns.ch</a>&#39;, set()),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(&#39;doh1.2.3.4.buga.xxxxx.yyy.invalid&#39;, set()),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(&#39;1.2.3.4.buga.xxxxx.yyy.invalid&#39;, set()),<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (&#39;<a href=3D"http://example.com" rel=3D"noreferrer" target=3D"_blan=
k">example.com</a>&#39;, set([IPAddr(&#39;2606:2800:21f:cb07:6820:80da:af6b=
:8b2c&#39;), IPAddr(&#39;93.184.215.14&#39;)])),<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (&#39;<a href=3D"http://www.example.com" rel=3D"noreferrer" target=3D"_=
blank">www.example.com</a>&#39;, set([IPAddr(&#39;2606:2800:21f:cb07:6820:8=
0da:af6b:8b2c&#39;), IPAddr(&#39;93.184.215.14&#39;)])),<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (&#39;<a href=3D"http://fail2ban.org" rel=3D"noreferrer" target=3D"_bla=
nk">fail2ban.org</a>&#39;, set([IPAddr(&#39;2001:bc8:1200:6:208:a2ff:fe0c:6=
1f8&#39;), IPAddr(&#39;51.159.55.100&#39;)])),<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (&#39;<a href=3D"http://www.fail2ban.org" rel=3D"noreferrer" target=3D"=
_blank">www.fail2ban.org</a>&#39;, set([IPAddr(&#39;2001:bc8:1200:6:208:a2f=
f:fe0c:61f8&#39;), IPAddr(&#39;51.159.55.100&#39;)])),<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0c.set(*i)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# if fast - precach=
e all host names as localhost addresses (speed-up getSelfIPs/ignoreself):<b=
r>
--- <br>
-2.34.1<br>
-<br>
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/000=
2-clientreadertestcase.py-set-correct-config-dir-for-t.patch b/dynamic-laye=
rs/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py=
-set-correct-config-dir-for-t.patch<br>
deleted file mode 100644<br>
index a60b0fd..0000000<br>
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clien=
treadertestcase.py-set-correct-config-dir-for-t.patch<br>
+++ /dev/null<br>
@@ -1,35 +0,0 @@<br>
-From 9f26da3cf854e48b7939c2a9baa0cb3ffbee5994 Mon Sep 17 00:00:00 2001<br>
-From: Yi Zhao &lt;<a href=3D"mailto:yi.zhao@windriver.com" target=3D"_blan=
k">yi.zhao@windriver.com</a>&gt;<br>
-Date: Thu, 11 Sep 2025 22:36:07 +0800<br>
-Subject: [PATCH] clientreadertestcase.py: set correct config dir for<br>
- testReadStockJailFilterComplete<br>
-<br>
-In test case testReadStockJailFilterComplete, set configuration<br>
-directory to CONFIG_DIR (/etc/fail2ban/filter.d on the target) instead<br>
-of the hardcoded &quot;config&quot; directory. Otherwise, the config files=
 will<br>
-not be found during runtime testing.<br>
-<br>
-Upstream-Status: Backport<br>
-[<a href=3D"https://github.com/fail2ban/fail2ban/commit/9f26da3cf854e48b79=
39c2a9baa0cb3ffbee5994" rel=3D"noreferrer" target=3D"_blank">https://github=
.com/fail2ban/fail2ban/commit/9f26da3cf854e48b7939c2a9baa0cb3ffbee5994</a>]=
<br>
-<br>
-Signed-off-by: Yi Zhao &lt;<a href=3D"mailto:yi.zhao@windriver.com" target=
=3D"_blank">yi.zhao@windriver.com</a>&gt;<br>
----<br>
- fail2ban/tests/clientreadertestcase.py | 2 +-<br>
- 1 file changed, 1 insertion(+), 1 deletion(-)<br>
-<br>
-diff --git a/fail2ban/tests/clientreadertestcase.py b/fail2ban/tests/clien=
treadertestcase.py<br>
-index e6a2806c..b8ebbbc7 100644<br>
---- a/fail2ban/tests/clientreadertestcase.py<br>
-+++ b/fail2ban/tests/clientreadertestcase.py<br>
-@@ -878,7 +878,7 @@ class JailsReaderTest(LogCaptureTestCase):<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.assertTrue(jai=
ls.getOptions())=C2=A0 =C2=A0 =C2=A0 =C2=A0# reads fine<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# grab all filter n=
ames<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filters =3D set(os.=
path.splitext(os.path.split(a)[1])[0]<br>
--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 for a in glob.glob(os.path.join(&#39;config&#39;, &#39;filter.d&#39;, &=
#39;*.conf&#39;))<br>
-+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 for a in glob.glob(os.path.join(CONFIG_DIR, &#39;filter.d&#39;, &#39;*.=
conf&#39;))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if not (a.endswith(&#39;common.conf&#=
39;) or a.endswith(&#39;-aggressive.conf&#39;)))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# get filters of al=
l jails (filter names without options inside filter[...])<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0filters_jail =3D se=
t(<br>
--- <br>
-2.34.1<br>
-<br>
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/<a href=
=3D"http://python3-fail2ban_git.bb" rel=3D"noreferrer" target=3D"_blank">py=
thon3-fail2ban_git.bb</a> b/dynamic-layers/meta-python/recipes-security/fai=
l2ban/<a href=3D"http://python3-fail2ban_git.bb" rel=3D"noreferrer" target=
=3D"_blank">python3-fail2ban_git.bb</a><br>
index b0b65de..c85953a 100644<br>
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/<a href=3D"http:=
//python3-fail2ban_git.bb" rel=3D"noreferrer" target=3D"_blank">python3-fai=
l2ban_git.bb</a><br>
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/<a href=3D"http:=
//python3-fail2ban_git.bb" rel=3D"noreferrer" target=3D"_blank">python3-fai=
l2ban_git.bb</a><br>
@@ -11,10 +11,8 @@ LIC_FILES_CHKSUM =3D &quot;file://COPYING;md5=3Decabc31e=
90311da843753ba772885d9f&quot;<br>
<br>
=C2=A0DEPENDS =3D &quot;python3-native&quot;<br>
<br>
-SRCREV =3D &quot;ac62658c10f492911f8a0037a0bcf97c8521cd78&quot;<br>
+SRCREV =3D &quot;2856092709470250dc299931bc748f112590059f&quot;<br>
=C2=A0SRC_URI =3D &quot;git://<a href=3D"http://github.com/fail2ban/fail2ba=
n.git;branch=3Dmaster;protocol=3Dhttps" rel=3D"noreferrer" target=3D"_blank=
">github.com/fail2ban/fail2ban.git;branch=3Dmaster;protocol=3Dhttps</a> \<b=
r>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://0001-example.com-changes-t=
he-IPs-again.-additionally-it-g.patch \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0file://0002-clientreadertestcase.=
py-set-correct-config-dir-for-t.patch \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://initd \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 file://run-ptest \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000ed5b7e063ffd14ae--

