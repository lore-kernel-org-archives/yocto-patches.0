Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E9CCCD1AB
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:45 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web11.1675.1760649759918546492
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=IZ1jwC4K;
 spf=pass (domain: konsulko.com, ip: 209.85.222.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7f04816589bso185828585a.3
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649759; x=1761254559; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YpaWOmauMhRrlDMu7SQmW6ZizwwTSzSX0ogStKqB9N4=;
        b=IZ1jwC4K242GLRRcM1HEeHYLrdh99Lf4OXFTYatqniyX55v9H02vgLmCp1IfOJtPvy
         3GlhqBsnzsZVHq/n2xwjdIzL3exMbNTNdQiQq/hhaGkRRXUYy8aFSy5SNNNUPk8O6J7s
         znxdYi6RNB6pj3swkndyVGXE30gdclVLdi+zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649759; x=1761254559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YpaWOmauMhRrlDMu7SQmW6ZizwwTSzSX0ogStKqB9N4=;
        b=XQw1eU/rdsUamEZJVX98g5pLAwzu6wNqQqh1lRoShUwhbS2Is75YcvJKEavxFcOdkJ
         divnqXwUL8xeOi079a/9kWqrYz0FTIgD5iIBURVZ4SovHHAR1Z5gLLe4Yvnq0oHBYKq9
         AqNXcXIZLzLEXugbhCLtoOw0t/Mm0fE6xyGy3on0OymdzSFT7F90mF9twy1sY1YYMA7z
         2RBKcM13Bo4ymabzs4LX03GshOyxYOARSpMqT3XPnunmO6glNKqGXd20H0ZsweQeoZ+1
         jT2VEeH6p/0wp1edkMigsbjtQd0Q2Wgge5ngIwlXeeO6VI9hhaXMBOQVb9Eee2zWu5vZ
         wqrQ==
X-Gm-Message-State: AOJu0Yw7tL8fJYOBbpzrJmjW/0RWNXbFPziQl9J/3c2jBz3+/qnlOPDk
	7BQIj0F2bdT5K1G4n8jBp2rtj0uYTHiklxGmgV35C1VS5ENgKuJuACtPEI8ZabtLAShch6Tu80q
	r0tHJ
X-Gm-Gg: ASbGncu1WAwdZFGN2lS5H8JJDn0UGXLGjDsbhWFo0xoBF0kUrlLcZfoInXUznDKaCSq
	0eofAa/q68IDYHX1F6C4bXeep94f31+AaKsden4ln6Xdea+CSkgkPUlXiNRofdQ8L4v87oB+muf
	simyFc6Oaa3UptUvYpVG4VZ10hnejSMWoa+9HtD0Wr4zLGUJEuhgHwsJFdsyMzlKF1hZJ6+7R00
	q7UtrJMw7F4bYBHmLdq5fIUu8mDqajn6hA1ijbMWnCoat8L65ERVqRVBTM9yImPZ5FJeASlWxpx
	VETWv+aRh61jxD/rpuLTnPaYwLNLHbLm1SZ/cdQWnmBSqFKJ/O2+Mo00ZABoeGb+8w9A3LAZY2S
	gTefznPCr7BXfPPBz24f5Wx5ojL+Epdo9d5InIXtlldmyRfB1zgAKv9SYOCfq1rWZeqA5xCfFuP
	ajp9bVqctvZBmBE/pJGZu0TEAfnaH7XwqmsaCjF/zfTsdUqrBK9yUc
X-Google-Smtp-Source: AGHT+IHwiZLsnWjlyUBL7s3Ol5Z81lyYdQlwChwLVdQDW0H979sm+bOIs/+XgO9Tw9btKf+xNZbNrw==
X-Received: by 2002:ac8:7d42:0:b0:4d8:a856:cdbc with SMTP id d75a77b69052e-4e89d3713d6mr20519901cf.40.1760649758428;
        Thu, 16 Oct 2025 14:22:38 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:37 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 07/15] python3-fail2ban: update to latest git rev
Date: Thu, 16 Oct 2025 17:22:06 -0400
Message-ID: <3b13ff12067a8090507b0aac2f1223a94b76de09.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2332

From: Yi Zhao <yi.zhao@windriver.com>

Update to latest git rev as the current version doesn't work with
OpenSSH 9.8+[1].

Ptest result:
$ ptest-runner python3-fail2ban
START: ptest-runner
2025-09-21T12:45
BEGIN: /usr/lib64/python3-fail2ban/ptest

Ran 538 tests in 13.045s
OK (skipped=3)
DURATION: 14
END: /usr/lib64/python3-fail2ban/ptest
2025-09-21T12:46
STOP: ptest-runner
TOTAL: 1 FAIL: 0

[1] https://github.com/fail2ban/fail2ban/commit/2fed408c05ac5206b490368d94599869bd6a056d

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...ges-the-IPs-again.-additionally-it-g.patch | 210 ------------------
 ...case.py-set-correct-config-dir-for-t.patch |  35 ---
 .../fail2ban/python3-fail2ban_git.bb          |   4 +-
 3 files changed, 1 insertion(+), 248 deletions(-)
 delete mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
 delete mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
deleted file mode 100644
index 73014ab..0000000
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
+++ /dev/null
@@ -1,210 +0,0 @@
-From 5b6c13f0aae79a23d94570bacd1b5796e57f088d Mon Sep 17 00:00:00 2001
-From: sebres <info@sebres.de>
-Date: Thu, 30 Jan 2025 01:05:30 +0100
-Subject: [PATCH] example.com changes the IPs, again... additionally it got
- more IPs, which look unstable now (depends on resolver), so replaced with
- fail2ban.org, that seems to resolve to single IPv4 and IPv6 (can be adjusted
- later for something more persistent)
-
-
-Upstream-Status: Backport
-[https://github.com/fail2ban/fail2ban/commit/5b6c13f0aae79a23d94570bacd1b5796e57f088d]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- .../tests/files/logs/apache-fakegooglebot     |  6 +-
- fail2ban/tests/files/testcase-usedns.log      |  4 +-
- fail2ban/tests/filtertestcase.py              | 58 +++++++++----------
- fail2ban/tests/utils.py                       |  4 +-
- 4 files changed, 36 insertions(+), 36 deletions(-)
-
-diff --git a/fail2ban/tests/files/logs/apache-fakegooglebot b/fail2ban/tests/files/logs/apache-fakegooglebot
-index b77a1a6b..024842fd 100644
---- a/fail2ban/tests/files/logs/apache-fakegooglebot
-+++ b/fail2ban/tests/files/logs/apache-fakegooglebot
-@@ -1,5 +1,5 @@
- # Apache 2.2
- # failJSON: { "time": "2015-01-31T14:29:44", "match": true, "host": "66.249.66.1" }
--66.249.66.1 - - - [31/Jan/2015:14:29:44 ] example.com "GET / HTTP/1.1" 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" + 293 1149 546
--# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host": "93.184.215.14" }
--93.184.215.14 - - - [31/Jan/2015:14:29:44 ] example.com "GET / HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
-+66.249.66.1 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET / HTTP/1.1" 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" + 293 1149 546
-+# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host": "51.159.55.100" }
-+51.159.55.100 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET / HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
-diff --git a/fail2ban/tests/files/testcase-usedns.log b/fail2ban/tests/files/testcase-usedns.log
-index eea6eb44..3e7b36bb 100644
---- a/fail2ban/tests/files/testcase-usedns.log
-+++ b/fail2ban/tests/files/testcase-usedns.log
-@@ -1,2 +1,2 @@
--Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2
--Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2
-+Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2
-+Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2
-diff --git a/fail2ban/tests/filtertestcase.py b/fail2ban/tests/filtertestcase.py
-index 20945b78..26961a1b 100644
---- a/fail2ban/tests/filtertestcase.py
-+++ b/fail2ban/tests/filtertestcase.py
-@@ -587,14 +587,14 @@ class IgnoreIP(LogCaptureTestCase):
- 				self.assertNotLogged("returned successfully")
- 
- 	def testIgnoreCauseOK(self):
--		ip = "93.184.215.14"
-+		ip = "51.159.55.100"
- 		for ignore_source in ["dns", "ip", "command"]:
- 			self.filter.logIgnoreIp(ip, True, ignore_source=ignore_source)
- 			self.assertLogged("[%s] Ignore %s by %s" % (self.jail.name, ip, ignore_source))
- 
- 	def testIgnoreCauseNOK(self):
--		self.filter.logIgnoreIp("example.com", False, ignore_source="NOT_LOGGED")
--		self.assertNotLogged("[%s] Ignore %s by %s" % (self.jail.name, "example.com", "NOT_LOGGED"))
-+		self.filter.logIgnoreIp("fail2ban.org", False, ignore_source="NOT_LOGGED")
-+		self.assertNotLogged("[%s] Ignore %s by %s" % (self.jail.name, "fail2ban.org", "NOT_LOGGED"))
- 
- 
- class IgnoreIPDNS(LogCaptureTestCase):
-@@ -607,7 +607,7 @@ class IgnoreIPDNS(LogCaptureTestCase):
- 		self.filter = FileFilter(self.jail)
- 
- 	def testIgnoreIPDNS(self):
--		for dns in ("www.epfl.ch", "example.com"):
-+		for dns in ("www.epfl.ch", "fail2ban.org"):
- 			self.filter.addIgnoreIP(dns)
- 			ips = DNSUtils.dnsToIp(dns)
- 			self.assertTrue(len(ips) > 0)
-@@ -1892,22 +1892,22 @@ class GetFailures(LogCaptureTestCase):
- 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
- 		# We should still catch failures with usedns = no ;-)
- 		output_yes = (
--			('93.184.215.14', 1, 1124013299.0,
--			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2']
-+			('51.159.55.100', 1, 1124013299.0,
-+			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2']
- 			),
--			('93.184.215.14', 1, 1124013539.0,
--			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
-+			('51.159.55.100', 1, 1124013539.0,
-+			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
- 			),
--			('2606:2800:21f:cb07:6820:80da:af6b:8b2c', 1, 1124013299.0,
--			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2']
-+			('2001:bc8:1200:6:208:a2ff:fe0c:61f8', 1, 1124013299.0,
-+			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2']
- 			),
- 		)
- 		if not unittest.F2B.no_network and not DNSUtils.IPv6IsAllowed():
- 			output_yes = output_yes[0:2]
- 
- 		output_no = (
--			('93.184.215.14', 1, 1124013539.0,
--			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
-+			('51.159.55.100', 1, 1124013539.0,
-+			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
- 			)
- 		)
- 
-@@ -2098,10 +2098,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 		super(DNSUtilsNetworkTests, self).setUp()
- 		#unittest.F2B.SkipIfNoNetwork()
- 
--	## example.com IPs considering IPv6 support (without network it is simulated via cache in utils).
-+	## fail2ban.org IPs considering IPv6 support (without network it is simulated via cache in utils).
- 	EXAMPLE_ADDRS = (
--		['93.184.215.14', '2606:2800:21f:cb07:6820:80da:af6b:8b2c'] if unittest.F2B.no_network or DNSUtils.IPv6IsAllowed() else \
--		['93.184.215.14']
-+		['51.159.55.100', '2001:bc8:1200:6:208:a2ff:fe0c:61f8'] if unittest.F2B.no_network or DNSUtils.IPv6IsAllowed() else \
-+		['51.159.55.100']
- 	)
- 
- 	def test_IPAddr(self):
-@@ -2163,13 +2163,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 		self.assertTrue(r < ip6)
- 
- 	def testUseDns(self):
--		res = DNSUtils.textToIp('www.example.com', 'no')
-+		res = DNSUtils.textToIp('www.fail2ban.org', 'no')
- 		self.assertSortedEqual(res, [])
- 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
--		res = DNSUtils.textToIp('www.example.com', 'warn')
-+		res = DNSUtils.textToIp('www.fail2ban.org', 'warn')
- 		# sort ipaddr, IPv4 is always smaller as IPv6
- 		self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
--		res = DNSUtils.textToIp('www.example.com', 'yes')
-+		res = DNSUtils.textToIp('www.fail2ban.org', 'yes')
- 		# sort ipaddr, IPv4 is always smaller as IPv6
- 		self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
- 
-@@ -2177,13 +2177,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
- 		# Test hostnames
- 		hostnames = [
--			'www.example.com',
-+			'www.fail2ban.org',
- 			'doh1.2.3.4.buga.xxxxx.yyy.invalid',
- 			'1.2.3.4.buga.xxxxx.yyy.invalid',
- 			]
- 		for s in hostnames:
- 			res = DNSUtils.textToIp(s, 'yes')
--			if s == 'www.example.com':
-+			if s == 'www.fail2ban.org':
- 				# sort ipaddr, IPv4 is always smaller as IPv6
- 				self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
- 			else:
-@@ -2234,8 +2234,8 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 
- 		self.assertEqual(IPAddr('192.0.2.0').getPTR(), '0.2.0.192.in-addr.arpa.')
- 		self.assertEqual(IPAddr('192.0.2.1').getPTR(), '1.2.0.192.in-addr.arpa.')
--		self.assertEqual(IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c').getPTR(), 
--			'c.2.b.8.b.6.f.a.a.d.0.8.0.2.8.6.7.0.b.c.f.1.2.0.0.0.8.2.6.0.6.2.ip6.arpa.')
-+		self.assertEqual(IPAddr('2001:db8::1').getPTR(), 
-+			'1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa.')
- 
- 	def testIPAddr_Equal6(self):
- 		self.assertEqual(
-@@ -2365,10 +2365,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 
- 	def testIPAddr_CompareDNS(self):
- 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
--		ips = IPAddr('example.com')
--		self.assertTrue(IPAddr("93.184.215.14").isInNet(ips))
--		self.assertEqual(IPAddr("2606:2800:21f:cb07:6820:80da:af6b:8b2c").isInNet(ips),
--		                        "2606:2800:21f:cb07:6820:80da:af6b:8b2c" in self.EXAMPLE_ADDRS)
-+		ips = IPAddr('fail2ban.org')
-+		self.assertTrue(IPAddr("51.159.55.100").isInNet(ips))
-+		self.assertEqual(IPAddr("2001:bc8:1200:6:208:a2ff:fe0c:61f8").isInNet(ips),
-+		                        "2001:bc8:1200:6:208:a2ff:fe0c:61f8" in self.EXAMPLE_ADDRS)
- 
- 	def testIPAddr_wrongDNS_IP(self):
- 		unittest.F2B.SkipIfNoNetwork()
-@@ -2376,11 +2376,11 @@ class DNSUtilsNetworkTests(unittest.TestCase):
- 		DNSUtils.ipToName('*')
- 
- 	def testIPAddr_Cached(self):
--		ips = [DNSUtils.dnsToIp('example.com'), DNSUtils.dnsToIp('example.com')]
-+		ips = [DNSUtils.dnsToIp('fail2ban.org'), DNSUtils.dnsToIp('fail2ban.org')]
- 		for ip1, ip2 in zip(ips, ips):
- 			self.assertEqual(id(ip1), id(ip2))
--		ip1 = IPAddr('93.184.215.14'); ip2 = IPAddr('93.184.215.14'); self.assertEqual(id(ip1), id(ip2))
--		ip1 = IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'); ip2 = IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'); self.assertEqual(id(ip1), id(ip2))
-+		ip1 = IPAddr('51.159.55.100'); ip2 = IPAddr('51.159.55.100'); self.assertEqual(id(ip1), id(ip2))
-+		ip1 = IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); ip2 = IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); self.assertEqual(id(ip1), id(ip2))
- 
- 	def test_NetworkInterfacesAddrs(self):
- 		for withMask in (False, True):
-diff --git a/fail2ban/tests/utils.py b/fail2ban/tests/utils.py
-index f71ba60a..e6ef54f3 100644
---- a/fail2ban/tests/utils.py
-+++ b/fail2ban/tests/utils.py
-@@ -326,8 +326,8 @@ def initTests(opts):
- 			('failed.dns.ch', set()),
- 			('doh1.2.3.4.buga.xxxxx.yyy.invalid', set()),
- 			('1.2.3.4.buga.xxxxx.yyy.invalid', set()),
--			('example.com', set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'), IPAddr('93.184.215.14')])),
--			('www.example.com', set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'), IPAddr('93.184.215.14')])),
-+			('fail2ban.org', set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'), IPAddr('51.159.55.100')])),
-+			('www.fail2ban.org', set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'), IPAddr('51.159.55.100')])),
- 		):
- 			c.set(*i)
- 		# if fast - precache all host names as localhost addresses (speed-up getSelfIPs/ignoreself):
--- 
-2.34.1
-
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
deleted file mode 100644
index a60b0fd..0000000
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
+++ /dev/null
@@ -1,35 +0,0 @@
-From 9f26da3cf854e48b7939c2a9baa0cb3ffbee5994 Mon Sep 17 00:00:00 2001
-From: Yi Zhao <yi.zhao@windriver.com>
-Date: Thu, 11 Sep 2025 22:36:07 +0800
-Subject: [PATCH] clientreadertestcase.py: set correct config dir for
- testReadStockJailFilterComplete
-
-In test case testReadStockJailFilterComplete, set configuration
-directory to CONFIG_DIR (/etc/fail2ban/filter.d on the target) instead
-of the hardcoded "config" directory. Otherwise, the config files will
-not be found during runtime testing.
-
-Upstream-Status: Backport
-[https://github.com/fail2ban/fail2ban/commit/9f26da3cf854e48b7939c2a9baa0cb3ffbee5994]
-
-Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
----
- fail2ban/tests/clientreadertestcase.py | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/fail2ban/tests/clientreadertestcase.py b/fail2ban/tests/clientreadertestcase.py
-index e6a2806c..b8ebbbc7 100644
---- a/fail2ban/tests/clientreadertestcase.py
-+++ b/fail2ban/tests/clientreadertestcase.py
-@@ -878,7 +878,7 @@ class JailsReaderTest(LogCaptureTestCase):
- 		self.assertTrue(jails.getOptions())       # reads fine
- 		# grab all filter names
- 		filters = set(os.path.splitext(os.path.split(a)[1])[0]
--			for a in glob.glob(os.path.join('config', 'filter.d', '*.conf'))
-+			for a in glob.glob(os.path.join(CONFIG_DIR, 'filter.d', '*.conf'))
- 				if not (a.endswith('common.conf') or a.endswith('-aggressive.conf')))
- 		# get filters of all jails (filter names without options inside filter[...])
- 		filters_jail = set(
--- 
-2.34.1
-
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index b0b65de..c85953a 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -11,10 +11,8 @@ LIC_FILES_CHKSUM = "file://COPYING;md5=ecabc31e90311da843753ba772885d9f"
 
 DEPENDS = "python3-native"
 
-SRCREV = "ac62658c10f492911f8a0037a0bcf97c8521cd78"
+SRCREV = "2856092709470250dc299931bc748f112590059f"
 SRC_URI = "git://github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
-           file://0001-example.com-changes-the-IPs-again.-additionally-it-g.patch \
-           file://0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch \
            file://initd \
            file://run-ptest \
            "
-- 
2.51.0


