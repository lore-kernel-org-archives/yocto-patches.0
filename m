Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B2BCCD1A5
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 21:22:45 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.web10.1662.1760649758366167433
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 16 Oct 2025 14:22:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=rEhMpC37;
 spf=pass (domain: konsulko.com, ip: 209.85.219.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78f75b0a058so16625316d6.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 14:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1760649757; x=1761254557; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+E8IaCcGdpN5iZStFDE/AVeu13mWI4ufctXXI7sAcc=;
        b=rEhMpC37P1MTRI3q48Idj7nvYc+QMJiJ9x0d6AxWlspTr4FpUnIFiVnXB6PTYYCO0G
         uYmpMDtgoItWIU2txgeiDQp6jsYS14/vheescLDOn+7k3NHxPmXv3jN2t9zNp9Qsqx6B
         CL/OGtMExOvxsop3j8eYvECUvCGQ02PN2j5jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760649757; x=1761254557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+E8IaCcGdpN5iZStFDE/AVeu13mWI4ufctXXI7sAcc=;
        b=aKwz8CpYW4nVMNLv0NO84t85R3FV/5wB7PSGy+j9Fanzo8cwC1V07Q4gGY+N0L8Okx
         vV1H6JfUC6SIJIL4ckM9wRvSXb4lHrWCPoC7JH1TA08aeRo2fq9i4l/ABaIMjHeUkKBZ
         VYpUbSnyoSgOmCWK95friz5BO8vFBd01HNBGKUxLhuBk01EJjdIrLcThXiMaeZsa1N5a
         VhIBn+AMRm6K6tYjjK82o2taqXBs1TkyGXc3NCeESZkcVEGL4BBXWzCR38sZrrhYwCHS
         9d8dQZorN8li+T1uNolqpx+PpdipzvQPMjDMsrOoUdjslczqGIPLebGM1g5DeqpdwQWb
         gyRA==
X-Gm-Message-State: AOJu0YzlmMCyiT0TZ3etk3GYdNA3eDjE/xzwhielbs2WXp15oRDCn+V6
	/JDQzyG9EEuve05Q3dWv7sR0io4Hgw5d+0qEzLCORtPFV96YRU5wUwjWkQ7QovSmk/5MzvsDB8p
	sMEcm
X-Gm-Gg: ASbGncsI5BjETE318rYdF6S/7a1nGxopLWkcoYakQldNSNHR9TUNmtaf3YxEvkSJyq1
	cxD9BPApjq5NTrY/w1dqtokNYhq7kdEFvH5bPpDnqtQu0gpW/ix9DU5eOfPXF3OvZpA4u9hYKMB
	1qGIxpFYEDjFOZNytqIDYWHep+wUOS57t83p1mOkFmGV7oN6WkAt2SAPRugERu6qdnLjLGDUA1n
	DS9Daob8rxEIjzQ2sKbnsgvN3MHfdaV0WYcgB0LLX5UsneNsKDX7CqOrcfb/F7mAEuLvAMNYKDD
	wDTUiVnzd0gJjbCaSkI8BAI7tN2RrMAJBuERehJpAcN916A0uOdjcZK4wwODWZ4e2f3EfixAAo6
	rr//xeTIREBVWcRBHNSiXZzO3mwVPDuSqMPnY88/ezGM+eytW5Uf1RDqrEiD9ss1XPhWzGV4fPw
	9Iy7XRz31Cn+wQIrU58MHatYaf8149OvyQ50DNmSNq+ahocYokACXZ
X-Google-Smtp-Source: AGHT+IFxUq81xz9t2yI2nfMAjsXpnn9LHNnHDwYmJzPlErjwaSBJiJXkh0OjVEOVWWwbLY/Dj6MGUg==
X-Received: by 2002:a05:6214:5289:b0:797:1a0d:cdd3 with SMTP id 6a1803df08f44-87c2057312dmr27229846d6.19.1760649756881;
        Thu, 16 Oct 2025 14:22:36 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c1c2fd4f4sm14647466d6.7.2025.10.16.14.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 14:22:36 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Marta Rybczynska <marta.rybczynska@ygreky.com>
Subject: [meta-security][PATCH 06/15] python3-fail2ban: fix ptest failures
Date: Thu, 16 Oct 2025 17:22:05 -0400
Message-ID: <8264087da918402e13f40e674ce6b054f58ad1a9.1760648348.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760648348.git.scott.murray@konsulko.com>
References: <cover.1760648348.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 16 Oct 2025 21:22:45 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2331

From: Yi Zhao <yi.zhao@windriver.com>

Fix ptest failures by backporting patches and updating test case config
files.

Before the patch:
  $ ptest-runner python3-fail2ban
  START: ptest-runner
  2025-09-11T15:42
  BEGIN: /usr/lib64/python3-fail2ban/ptest
  <snip>
  Ran 524 tests in 23.023s

  FAILED (failures=5, errors=7, skipped=3)
  DURATION: 24
  END: /usr/lib64/python3-fail2ban/ptest
  2025-09-11T15:42
  STOP: ptest-runner
  TOTAL: 1 FAIL: 1

After the patch:
  $ ptest-runner python3-fail2ban
  START: ptest-runner
  2025-09-11T15:59
  BEGIN: /usr/lib64/python3-fail2ban/ptest
  <snip>
  Ran 524 tests in 25.982s

  OK (skipped=3)
  DURATION: 27
  END: /usr/lib64/python3-fail2ban/ptest
  2025-09-11T15:59
  STOP: ptest-runner
  TOTAL: 1 FAIL: 0

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 ...ges-the-IPs-again.-additionally-it-g.patch | 210 ++++++++++++++++++
 ...case.py-set-correct-config-dir-for-t.patch |  35 +++
 .../fail2ban/python3-fail2ban_git.bb          |  12 +-
 3 files changed, 256 insertions(+), 1 deletion(-)
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
 create mode 100644 dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch

diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
new file mode 100644
index 0000000..73014ab
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0001-example.com-changes-the-IPs-again.-additionally-it-g.patch
@@ -0,0 +1,210 @@
+From 5b6c13f0aae79a23d94570bacd1b5796e57f088d Mon Sep 17 00:00:00 2001
+From: sebres <info@sebres.de>
+Date: Thu, 30 Jan 2025 01:05:30 +0100
+Subject: [PATCH] example.com changes the IPs, again... additionally it got
+ more IPs, which look unstable now (depends on resolver), so replaced with
+ fail2ban.org, that seems to resolve to single IPv4 and IPv6 (can be adjusted
+ later for something more persistent)
+
+
+Upstream-Status: Backport
+[https://github.com/fail2ban/fail2ban/commit/5b6c13f0aae79a23d94570bacd1b5796e57f088d]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ .../tests/files/logs/apache-fakegooglebot     |  6 +-
+ fail2ban/tests/files/testcase-usedns.log      |  4 +-
+ fail2ban/tests/filtertestcase.py              | 58 +++++++++----------
+ fail2ban/tests/utils.py                       |  4 +-
+ 4 files changed, 36 insertions(+), 36 deletions(-)
+
+diff --git a/fail2ban/tests/files/logs/apache-fakegooglebot b/fail2ban/tests/files/logs/apache-fakegooglebot
+index b77a1a6b..024842fd 100644
+--- a/fail2ban/tests/files/logs/apache-fakegooglebot
++++ b/fail2ban/tests/files/logs/apache-fakegooglebot
+@@ -1,5 +1,5 @@
+ # Apache 2.2
+ # failJSON: { "time": "2015-01-31T14:29:44", "match": true, "host": "66.249.66.1" }
+-66.249.66.1 - - - [31/Jan/2015:14:29:44 ] example.com "GET / HTTP/1.1" 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" + 293 1149 546
+-# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host": "93.184.215.14" }
+-93.184.215.14 - - - [31/Jan/2015:14:29:44 ] example.com "GET / HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
++66.249.66.1 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET / HTTP/1.1" 200 814 "-" "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" + 293 1149 546
++# failJSON: { "time": "2015-01-31T14:29:44", "match": false, "host": "51.159.55.100" }
++51.159.55.100 - - - [31/Jan/2015:14:29:44 ] fail2ban.org "GET / HTTP/1.1" 200 814 "-" "NOT A __GOOGLE_BOT__" + 293 1149 546
+diff --git a/fail2ban/tests/files/testcase-usedns.log b/fail2ban/tests/files/testcase-usedns.log
+index eea6eb44..3e7b36bb 100644
+--- a/fail2ban/tests/files/testcase-usedns.log
++++ b/fail2ban/tests/files/testcase-usedns.log
+@@ -1,2 +1,2 @@
+-Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2
+-Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2
++Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2
++Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2
+diff --git a/fail2ban/tests/filtertestcase.py b/fail2ban/tests/filtertestcase.py
+index 20945b78..26961a1b 100644
+--- a/fail2ban/tests/filtertestcase.py
++++ b/fail2ban/tests/filtertestcase.py
+@@ -587,14 +587,14 @@ class IgnoreIP(LogCaptureTestCase):
+ 				self.assertNotLogged("returned successfully")
+ 
+ 	def testIgnoreCauseOK(self):
+-		ip = "93.184.215.14"
++		ip = "51.159.55.100"
+ 		for ignore_source in ["dns", "ip", "command"]:
+ 			self.filter.logIgnoreIp(ip, True, ignore_source=ignore_source)
+ 			self.assertLogged("[%s] Ignore %s by %s" % (self.jail.name, ip, ignore_source))
+ 
+ 	def testIgnoreCauseNOK(self):
+-		self.filter.logIgnoreIp("example.com", False, ignore_source="NOT_LOGGED")
+-		self.assertNotLogged("[%s] Ignore %s by %s" % (self.jail.name, "example.com", "NOT_LOGGED"))
++		self.filter.logIgnoreIp("fail2ban.org", False, ignore_source="NOT_LOGGED")
++		self.assertNotLogged("[%s] Ignore %s by %s" % (self.jail.name, "fail2ban.org", "NOT_LOGGED"))
+ 
+ 
+ class IgnoreIPDNS(LogCaptureTestCase):
+@@ -607,7 +607,7 @@ class IgnoreIPDNS(LogCaptureTestCase):
+ 		self.filter = FileFilter(self.jail)
+ 
+ 	def testIgnoreIPDNS(self):
+-		for dns in ("www.epfl.ch", "example.com"):
++		for dns in ("www.epfl.ch", "fail2ban.org"):
+ 			self.filter.addIgnoreIP(dns)
+ 			ips = DNSUtils.dnsToIp(dns)
+ 			self.assertTrue(len(ips) > 0)
+@@ -1892,22 +1892,22 @@ class GetFailures(LogCaptureTestCase):
+ 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
+ 		# We should still catch failures with usedns = no ;-)
+ 		output_yes = (
+-			('93.184.215.14', 1, 1124013299.0,
+-			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2']
++			('51.159.55.100', 1, 1124013299.0,
++			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2']
+ 			),
+-			('93.184.215.14', 1, 1124013539.0,
+-			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
++			('51.159.55.100', 1, 1124013539.0,
++			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
+ 			),
+-			('2606:2800:21f:cb07:6820:80da:af6b:8b2c', 1, 1124013299.0,
+-			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from example.com port 51332 ssh2']
++			('2001:bc8:1200:6:208:a2ff:fe0c:61f8', 1, 1124013299.0,
++			  ['Aug 14 11:54:59 i60p295 sshd[12365]: Failed publickey for roehl from fail2ban.org port 51332 ssh2']
+ 			),
+ 		)
+ 		if not unittest.F2B.no_network and not DNSUtils.IPv6IsAllowed():
+ 			output_yes = output_yes[0:2]
+ 
+ 		output_no = (
+-			('93.184.215.14', 1, 1124013539.0,
+-			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:93.184.215.14 port 51332 ssh2']
++			('51.159.55.100', 1, 1124013539.0,
++			  ['Aug 14 11:58:59 i60p295 sshd[12365]: Failed publickey for roehl from ::ffff:51.159.55.100 port 51332 ssh2']
+ 			)
+ 		)
+ 
+@@ -2098,10 +2098,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 		super(DNSUtilsNetworkTests, self).setUp()
+ 		#unittest.F2B.SkipIfNoNetwork()
+ 
+-	## example.com IPs considering IPv6 support (without network it is simulated via cache in utils).
++	## fail2ban.org IPs considering IPv6 support (without network it is simulated via cache in utils).
+ 	EXAMPLE_ADDRS = (
+-		['93.184.215.14', '2606:2800:21f:cb07:6820:80da:af6b:8b2c'] if unittest.F2B.no_network or DNSUtils.IPv6IsAllowed() else \
+-		['93.184.215.14']
++		['51.159.55.100', '2001:bc8:1200:6:208:a2ff:fe0c:61f8'] if unittest.F2B.no_network or DNSUtils.IPv6IsAllowed() else \
++		['51.159.55.100']
+ 	)
+ 
+ 	def test_IPAddr(self):
+@@ -2163,13 +2163,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 		self.assertTrue(r < ip6)
+ 
+ 	def testUseDns(self):
+-		res = DNSUtils.textToIp('www.example.com', 'no')
++		res = DNSUtils.textToIp('www.fail2ban.org', 'no')
+ 		self.assertSortedEqual(res, [])
+ 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
+-		res = DNSUtils.textToIp('www.example.com', 'warn')
++		res = DNSUtils.textToIp('www.fail2ban.org', 'warn')
+ 		# sort ipaddr, IPv4 is always smaller as IPv6
+ 		self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
+-		res = DNSUtils.textToIp('www.example.com', 'yes')
++		res = DNSUtils.textToIp('www.fail2ban.org', 'yes')
+ 		# sort ipaddr, IPv4 is always smaller as IPv6
+ 		self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
+ 
+@@ -2177,13 +2177,13 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
+ 		# Test hostnames
+ 		hostnames = [
+-			'www.example.com',
++			'www.fail2ban.org',
+ 			'doh1.2.3.4.buga.xxxxx.yyy.invalid',
+ 			'1.2.3.4.buga.xxxxx.yyy.invalid',
+ 			]
+ 		for s in hostnames:
+ 			res = DNSUtils.textToIp(s, 'yes')
+-			if s == 'www.example.com':
++			if s == 'www.fail2ban.org':
+ 				# sort ipaddr, IPv4 is always smaller as IPv6
+ 				self.assertSortedEqual(res, self.EXAMPLE_ADDRS)
+ 			else:
+@@ -2234,8 +2234,8 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 
+ 		self.assertEqual(IPAddr('192.0.2.0').getPTR(), '0.2.0.192.in-addr.arpa.')
+ 		self.assertEqual(IPAddr('192.0.2.1').getPTR(), '1.2.0.192.in-addr.arpa.')
+-		self.assertEqual(IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c').getPTR(), 
+-			'c.2.b.8.b.6.f.a.a.d.0.8.0.2.8.6.7.0.b.c.f.1.2.0.0.0.8.2.6.0.6.2.ip6.arpa.')
++		self.assertEqual(IPAddr('2001:db8::1').getPTR(), 
++			'1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.8.b.d.0.1.0.0.2.ip6.arpa.')
+ 
+ 	def testIPAddr_Equal6(self):
+ 		self.assertEqual(
+@@ -2365,10 +2365,10 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 
+ 	def testIPAddr_CompareDNS(self):
+ 		#unittest.F2B.SkipIfNoNetwork() ## without network it is simulated via cache in utils.
+-		ips = IPAddr('example.com')
+-		self.assertTrue(IPAddr("93.184.215.14").isInNet(ips))
+-		self.assertEqual(IPAddr("2606:2800:21f:cb07:6820:80da:af6b:8b2c").isInNet(ips),
+-		                        "2606:2800:21f:cb07:6820:80da:af6b:8b2c" in self.EXAMPLE_ADDRS)
++		ips = IPAddr('fail2ban.org')
++		self.assertTrue(IPAddr("51.159.55.100").isInNet(ips))
++		self.assertEqual(IPAddr("2001:bc8:1200:6:208:a2ff:fe0c:61f8").isInNet(ips),
++		                        "2001:bc8:1200:6:208:a2ff:fe0c:61f8" in self.EXAMPLE_ADDRS)
+ 
+ 	def testIPAddr_wrongDNS_IP(self):
+ 		unittest.F2B.SkipIfNoNetwork()
+@@ -2376,11 +2376,11 @@ class DNSUtilsNetworkTests(unittest.TestCase):
+ 		DNSUtils.ipToName('*')
+ 
+ 	def testIPAddr_Cached(self):
+-		ips = [DNSUtils.dnsToIp('example.com'), DNSUtils.dnsToIp('example.com')]
++		ips = [DNSUtils.dnsToIp('fail2ban.org'), DNSUtils.dnsToIp('fail2ban.org')]
+ 		for ip1, ip2 in zip(ips, ips):
+ 			self.assertEqual(id(ip1), id(ip2))
+-		ip1 = IPAddr('93.184.215.14'); ip2 = IPAddr('93.184.215.14'); self.assertEqual(id(ip1), id(ip2))
+-		ip1 = IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'); ip2 = IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'); self.assertEqual(id(ip1), id(ip2))
++		ip1 = IPAddr('51.159.55.100'); ip2 = IPAddr('51.159.55.100'); self.assertEqual(id(ip1), id(ip2))
++		ip1 = IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); ip2 = IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'); self.assertEqual(id(ip1), id(ip2))
+ 
+ 	def test_NetworkInterfacesAddrs(self):
+ 		for withMask in (False, True):
+diff --git a/fail2ban/tests/utils.py b/fail2ban/tests/utils.py
+index f71ba60a..e6ef54f3 100644
+--- a/fail2ban/tests/utils.py
++++ b/fail2ban/tests/utils.py
+@@ -326,8 +326,8 @@ def initTests(opts):
+ 			('failed.dns.ch', set()),
+ 			('doh1.2.3.4.buga.xxxxx.yyy.invalid', set()),
+ 			('1.2.3.4.buga.xxxxx.yyy.invalid', set()),
+-			('example.com', set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'), IPAddr('93.184.215.14')])),
+-			('www.example.com', set([IPAddr('2606:2800:21f:cb07:6820:80da:af6b:8b2c'), IPAddr('93.184.215.14')])),
++			('fail2ban.org', set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'), IPAddr('51.159.55.100')])),
++			('www.fail2ban.org', set([IPAddr('2001:bc8:1200:6:208:a2ff:fe0c:61f8'), IPAddr('51.159.55.100')])),
+ 		):
+ 			c.set(*i)
+ 		# if fast - precache all host names as localhost addresses (speed-up getSelfIPs/ignoreself):
+-- 
+2.34.1
+
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
new file mode 100644
index 0000000..a60b0fd
--- /dev/null
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/files/0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch
@@ -0,0 +1,35 @@
+From 9f26da3cf854e48b7939c2a9baa0cb3ffbee5994 Mon Sep 17 00:00:00 2001
+From: Yi Zhao <yi.zhao@windriver.com>
+Date: Thu, 11 Sep 2025 22:36:07 +0800
+Subject: [PATCH] clientreadertestcase.py: set correct config dir for
+ testReadStockJailFilterComplete
+
+In test case testReadStockJailFilterComplete, set configuration
+directory to CONFIG_DIR (/etc/fail2ban/filter.d on the target) instead
+of the hardcoded "config" directory. Otherwise, the config files will
+not be found during runtime testing.
+
+Upstream-Status: Backport
+[https://github.com/fail2ban/fail2ban/commit/9f26da3cf854e48b7939c2a9baa0cb3ffbee5994]
+
+Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
+---
+ fail2ban/tests/clientreadertestcase.py | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/fail2ban/tests/clientreadertestcase.py b/fail2ban/tests/clientreadertestcase.py
+index e6a2806c..b8ebbbc7 100644
+--- a/fail2ban/tests/clientreadertestcase.py
++++ b/fail2ban/tests/clientreadertestcase.py
+@@ -878,7 +878,7 @@ class JailsReaderTest(LogCaptureTestCase):
+ 		self.assertTrue(jails.getOptions())       # reads fine
+ 		# grab all filter names
+ 		filters = set(os.path.splitext(os.path.split(a)[1])[0]
+-			for a in glob.glob(os.path.join('config', 'filter.d', '*.conf'))
++			for a in glob.glob(os.path.join(CONFIG_DIR, 'filter.d', '*.conf'))
+ 				if not (a.endswith('common.conf') or a.endswith('-aggressive.conf')))
+ 		# get filters of all jails (filter names without options inside filter[...])
+ 		filters_jail = set(
+-- 
+2.34.1
+
diff --git a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
index 7312bf8..b0b65de 100644
--- a/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
+++ b/dynamic-layers/meta-python/recipes-security/fail2ban/python3-fail2ban_git.bb
@@ -13,6 +13,8 @@ DEPENDS = "python3-native"
 
 SRCREV = "ac62658c10f492911f8a0037a0bcf97c8521cd78"
 SRC_URI = "git://github.com/fail2ban/fail2ban.git;branch=master;protocol=https \
+           file://0001-example.com-changes-the-IPs-again.-additionally-it-g.patch \
+           file://0002-clientreadertestcase.py-set-correct-config-dir-for-t.patch \
            file://initd \
            file://run-ptest \
            "
@@ -47,8 +49,16 @@ do_install_ptest:append () {
     sed -i -e 's/##PYTHON##/python3/g' ${D}${PTEST_PATH}/run-ptest
     install -D ${S}/bin/* ${D}${PTEST_PATH}/bin
     rm -f ${D}${PTEST_PATH}/bin/fail2ban-python
-}
 
+    for i in checklogtype.conf zzz-generic-example.conf zzz-sshd-obsolete-multiline.conf; do
+        sed -i -e 's|^before =.*|before = ${sysconfdir}/fail2ban/filter.d/common.conf|g' \
+            ${D}${PYTHON_SITEPACKAGES_DIR}/fail2ban/tests/config/filter.d/${i}
+    done
+
+    install -m 0644 ${S}/README.md ${D}${PTEST_PATH}
+    sed -i -e 's|^logpath = README.md|logpath = ${PTEST_PATH}/README.md|g' \
+            ${D}${PYTHON_SITEPACKAGES_DIR}/fail2ban/tests/config/jail.conf
+}
 
 INITSCRIPT_PACKAGES = "${PN}"
 INITSCRIPT_NAME = "fail2ban-server"
-- 
2.51.0


