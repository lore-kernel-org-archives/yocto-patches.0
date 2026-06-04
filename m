Return-Path: <jackson.james9803@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B40CD6E6B
	for <webhook@archiver.kernel.org>; Thu,  4 Jun 2026 08:05:46 +0000 (UTC)
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6325.1780560341023944906
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 04 Jun 2026 01:05:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=P1uzTle+;
 spf=pass (domain: gmail.com, ip: 209.85.210.180, mailfrom: jackson.james9803@gmail.com)
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8422a92b6d6so216620b3a.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 01:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780560340; x=1781165140; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdrzx0dUEsn+gTsswqZ0cft2kaG5EuQiBy3rRpFhkrY=;
        b=P1uzTle+foiDut6zmYpgx3pXq652p6BFOQIdfo5egXUBfvsp2U7VOiL5ArYT0p0d3Y
         Po8A2ZHPnQbuLyeDmqWT/5yPPCkLFKuStLvYigCf/NrNdobvyUtBxy5wbBt7QhDIr+PL
         SR81jIqVWea9R0uZgf2G3y17V0nvLXzVkpWpgnSePjO3CyWthB5wCDLD7jCnzp4MUx5P
         EFpsZL1KixE0oOqZQyFOQT1UGpVisOfaxOSqi5sTOo0W6LoNp4qVfIdaphJn9dSngGaw
         gLtPgZRs2VcG6E0NmqgKKPOrOTFxTrvHVjJia74hscW4EK8ZTZPeYz3tO+4SblWoOkFk
         5CIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780560340; x=1781165140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qdrzx0dUEsn+gTsswqZ0cft2kaG5EuQiBy3rRpFhkrY=;
        b=IqIOj1aBorOHubzUpzJb99y/9XixVBPoeKoTVk0KhLMer2U9JqEkk8U+xB8VMIPLS4
         fgX9ThrLCSg1RvsdGgZBiWyJoNfKVa4V6mRXs4CTuaaPnrFIunCbaUSQT6pUU4UgnOPm
         /2UOctOoyJ9r59X491vvasoPQb0WWXNklItmi8YHd7QsSVQMnOQKinh9hjTZD/Uwizuw
         i85quRoArh7YxO6cnGwVworvQe31L7WeSC2ec+EcF0nO+AtxXxZ+ln+d+q9zxGoNEiVs
         L70XYIqjaF5lv3/ZwnkFlt4+RRER0uVMqKo/s3dGYN7nEIa8PQXCg2Mtm1ui8El3sBMu
         gI0Q==
X-Gm-Message-State: AOJu0Yz1d00ozxJd1Vp1M7TLHjZGSx/xHUXLF4gKV3+vWANNyCPaEgYj
	og7bRRglfGL8XKIxiOyDj7rQ6KryWfS3rs+JRNSIiGhPlk2uUQttGiLu8ovj9w==
X-Gm-Gg: Acq92OF8P9BAmrT9ev9f+9nvJjTVjisMm2gTBYCk5GKzk7CZH1svcE1L8xhIbVlhi6E
	7N82jXZTVh+LDikrXEqgzBBt9balDredrfUxSc5fQ4ONNMeoBd9RCZ0UjLqDabZ8uplXdfky6Fq
	yw0Y5W3sW+YkoilK6QNcVf8pF5vFp3XkXe8p3VnJ5zLtoKiTRUy+IaZjPk9aVPbEjGKOrNHStV1
	xKsVIowJI/FJly1jOMByKIEnpUlkXTiBN+hFw6COrsBqOlDXX54tMh5xeOEN7qnFgsKezFyc9GG
	6jo+hAqcRnNJ3VbcYxOibe1z7VD3hbuZ+ENtLsaXoQHM7ohH/gZPpBH4sVyJ2+sUJDvR9ivHN22
	zHqFug7zQkELHywqSs+9QNWGMW9tYuuaeWALtCftC2m1aG359EI6iaA1JqHOn2RXr+M6st60yG7
	C5COspjy15uNjvGECq8cBjT/HBBnm/26noME3PbOF3Ba8Fgva/cfYA6bqy
X-Received: by 2002:a05:6a00:ad84:b0:842:499d:450e with SMTP id d2e1a72fcca58-8429b6a46c2mr2221407b3a.20.1780560340173;
        Thu, 04 Jun 2026 01:05:40 -0700 (PDT)
Received: from LL-868L.kpit.com ([103.155.222.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842828e21c8sm6139001b3a.49.2026.06.04.01.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 01:05:39 -0700 (PDT)
From: Nitin Wankhade <jackson.james9803@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nitin.wankhade@kpit.com,
	Nitin Wankhade <nitin.wankhade333@gmail.com>
Subject: [meta-lts-collab][kirkstone][PATCH 4/7] strongswan: Fix CVE-2026-35331
Date: Thu,  4 Jun 2026 13:35:03 +0530
Message-Id: <20260604080506.274123-4-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260604080506.274123-1-nitin.wankhade@kpit.com>
References: <20260604080506.274123-1-nitin.wankhade@kpit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 04 Jun 2026 08:05:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4135

From: Nitin Wankhade <nitin.wankhade333@gmail.com>

Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]

Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
---
 ...-insensitive-matching-and-reject-exc.patch | 145 ++++++++++++++++++
 .../strongswan/strongswan_5.9.13.bbappend     |   1 +
 2 files changed, 146 insertions(+)
 create mode 100644 meta-networking/recipes-support/strongswan/files/constraints-Case-insensitive-matching-and-reject-exc.patch

diff --git a/meta-networking/recipes-support/strongswan/files/constraints-Case-insensitive-matching-and-reject-exc.patch b/meta-networking/recipes-support/strongswan/files/constraints-Case-insensitive-matching-and-reject-exc.patch
new file mode 100644
index 0000000..40ca317
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/files/constraints-Case-insensitive-matching-and-reject-exc.patch
@@ -0,0 +1,145 @@
+From: Tobias Brunner <tobias@strongswan.org>
+Date: Mon, 23 Mar 2026 17:45:11 +0100
+Subject: constraints: Case-insensitive matching and reject excluded DN name
+ constraints
+
+The case is generally ignored when matching identities.  So this is
+an issue with excluded name constraints where a malicious intermediate
+CA could evade the constraints by issuing certificates with names that
+just modify the case (e.g. strongSwan.org instead strongswan.org).
+
+Note that it's likely that permitted name constraints are preferred over
+excluded name constraints as it might be difficult to come up with a
+conclusive list of names to exclude.
+
+With directoryName (DN) name constraints the issue is a bit more comples.
+Some RDNs have to be matched in a case-insensitive manner, which we e.g.
+do in `identification.c::rdn_equals`.  By not doing it for name
+constraints, a malicious intermediate CA could evade an excluded name
+constraint just by modifying the case in such an RDN.
+
+While we could use the mentioned function in `dn_matches`, this doesn't
+properly fix the problem because the function is basically too strict.
+Especially in regards to RDNs of type UTF8String, which are only compared
+binary.  To match these properly, we'd have to implement the string
+preparation described in RFC 5280, section 7.1 and the referenced RFCs.
+Until that's the case, we reject excluded name constraints of type
+directoryName as we are unable to enforce them.
+
+Fixes: a2b340764fac ("Implemented NameConstraint matching in constraints plugin")
+Fixes: CVE-2026-35331
+
+CVE: CVE-2026-35331
+Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]
+Patch is refreshed as per the source code version 5.9.13
+Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
+===
+diff --git a/src/libstrongswan/plugins/constraints/constraints_validator.c b/src/libstrongswan/plugins/constraints/constraints_validator.c
+index b1f60fb..a04720a 100644
+--- a/src/libstrongswan/plugins/constraints/constraints_validator.c
++++ b/src/libstrongswan/plugins/constraints/constraints_validator.c
+@@ -52,6 +52,18 @@ static bool check_pathlen(x509_t *issuer, int pathlen)
+ 	return TRUE;
+ }
+ 
++/**
++ * Check if the constraint and ID strings match case-insensitively
++ */
++static bool string_matches(chunk_t constraint, chunk_t id)
++{
++       /* make sure the two strings have actually the same length */
++       return constraint.len == id.len &&
++                  memchr(constraint.ptr, 0, constraint.len) == NULL &&
++                  memchr(id.ptr, 0, id.len) == NULL &&
++                  strncasecmp(constraint.ptr, id.ptr, constraint.len) == 0;
++}
++
+ /**
+  * Check if a FQDN constraint matches
+  */
+@@ -67,7 +79,7 @@ static bool fqdn_matches(identification_t *constraint, identification_t *id)
+ 		return FALSE;
+ 	}
+ 	diff = chunk_create(i.ptr, i.len - c.len);
+-	if (!chunk_equals(c, chunk_skip(i, diff.len)))
++	if (!string_matches(c, chunk_skip(i, diff.len)))
+ 	{
+ 		return FALSE;
+ 	}
+@@ -98,10 +110,10 @@ static bool email_matches(identification_t *constraint, identification_t *id)
+ 	}
+ 	if (memchr(c.ptr, '@', c.len))
+ 	{	/* constraint is a full email address */
+-		return chunk_equals(c, i);
++		return string_matches(c, i);
+ 	}
+ 	diff = chunk_create(i.ptr, i.len - c.len);
+-	if (!diff.len || !chunk_equals(c, chunk_skip(i, diff.len)))
++	if (!diff.len || !string_matches(c, chunk_skip(i, diff.len)))
+ 	{
+ 		return FALSE;
+ 	}
+diff --git a/src/libstrongswan/tests/suites/test_certnames.c b/src/libstrongswan/tests/suites/test_certnames.c
+index 3672912..4441912 100644
+--- a/src/libstrongswan/tests/suites/test_certnames.c
++++ b/src/libstrongswan/tests/suites/test_certnames.c
+@@ -194,8 +194,10 @@ static struct {
+ 	bool good;
+ } permitted_san[] = {
+ 	{ ID_FQDN, ".strongswan.org", "test.strongswan.org", TRUE },
++	{ ID_FQDN, ".strongswan.org", "test.strongSwan.org", TRUE },
+ 	{ ID_FQDN, "strongswan.org", "test.strongswan.org", TRUE },
+ 	{ ID_FQDN, "a.b.c.strongswan.org", "d.a.b.c.strongswan.org", TRUE },
++	{ ID_FQDN, "a.b.c.strongswan.org", "d.A.b.C.strongswan.org", TRUE },
+ 	{ ID_FQDN, "a.b.c.strongswan.org", "a.b.c.d.strongswan.org", FALSE },
+ 	{ ID_FQDN, "strongswan.org", "strongswan.org.com", FALSE },
+ 	{ ID_FQDN, ".strongswan.org", "strongswan.org", FALSE },
+@@ -203,8 +205,11 @@ static struct {
+ 	{ ID_FQDN, "strongswan.org", "swan.org", FALSE },
+ 	{ ID_FQDN, "strongswan.org", "swan.org", FALSE },
+ 	{ ID_RFC822_ADDR, "tester@strongswan.org", "tester@strongswan.org", TRUE },
++	{ ID_RFC822_ADDR, "tester@strongswan.org", "tester@strongSwan.org", TRUE },
++	{ ID_RFC822_ADDR, "tester@strongswan.org", "TESTER@strongswan.org", TRUE },
+ 	{ ID_RFC822_ADDR, "tester@strongswan.org", "atester@strongswan.org", FALSE },
+ 	{ ID_RFC822_ADDR, "strongswan.org", "tester@strongswan.org", TRUE },
++	{ ID_RFC822_ADDR, "strongswan.org", "tester@strongSwan.org", TRUE },
+ 	{ ID_RFC822_ADDR, "strongswan.org", "tester@test.strongswan.org", FALSE },
+ 	{ ID_RFC822_ADDR, ".strongswan.org", "tester@test.strongswan.org", TRUE },
+ 	{ ID_RFC822_ADDR, ".strongswan.org", "tester@strongswan.org", FALSE },
+@@ -232,11 +237,11 @@ static struct {
+ 	char *subject;
+ 	bool good;
+ } excluded_dn[] = {
+-	{ "C=CH, O=another", "C=CH, O=strongSwan, CN=tester", TRUE },
+-	{ "C=CH, O=another", "C=CH, O=anot", TRUE },
+-	{ "C=CH, O=another", "C=CH, O=anot, CN=tester", TRUE },
++	{ "C=CH, O=another", "C=CH, O=strongSwan, CN=tester", FALSE },
++	{ "C=CH, O=another", "C=CH, O=anot", FALSE },
++	{ "C=CH, O=another", "C=CH, O=anot, CN=tester", FALSE },
+ 	{ "C=CH, O=another", "C=CH, O=another, CN=tester", FALSE },
+-	{ "C=CH, O=another", "C=CH, CN=tester, O=another", TRUE },
++	{ "C=CH, O=another", "C=CH, CN=tester, O=another", FALSE },
+ };
+ 
+ START_TEST(test_excluded_dn)
+@@ -266,7 +271,9 @@ static struct {
+ } excluded_san[] = {
+ 	{ ID_FQDN, ".strongswan.org", "test.strongswan.org", FALSE },
+ 	{ ID_FQDN, "strongswan.org", "test.strongswan.org", FALSE },
++	{ ID_FQDN, "strongswan.org", "test.strongSwan.org", FALSE },
+ 	{ ID_FQDN, "a.b.c.strongswan.org", "d.a.b.c.strongswan.org", FALSE },
++	{ ID_FQDN, "a.b.c.strongswan.org", "d.a.b.C.strongswan.org", FALSE },
+ 	{ ID_FQDN, "a.b.c.strongswan.org", "a.b.c.d.strongswan.org", TRUE },
+ 	{ ID_FQDN, "strongswan.org", "strongswan.org.com", TRUE },
+ 	{ ID_FQDN, ".strongswan.org", "strongswan.org", TRUE },
+@@ -274,8 +281,10 @@ static struct {
+ 	{ ID_FQDN, "strongswan.org", "swan.org", TRUE },
+ 	{ ID_FQDN, "strongswan.org", "swan.org", TRUE },
+ 	{ ID_RFC822_ADDR, "tester@strongswan.org", "tester@strongswan.org", FALSE },
++	{ ID_RFC822_ADDR, "tester@strongswan.org", "TESTER@strongswan.org", FALSE },
+ 	{ ID_RFC822_ADDR, "tester@strongswan.org", "atester@strongswan.org", TRUE },
+ 	{ ID_RFC822_ADDR, "strongswan.org", "tester@strongswan.org", FALSE },
++	{ ID_RFC822_ADDR, "strongswan.org", "tester@strongSwan.org", FALSE },
+ 	{ ID_RFC822_ADDR, "strongswan.org", "tester@test.strongswan.org", TRUE },
+ 	{ ID_RFC822_ADDR, ".strongswan.org", "tester@test.strongswan.org", FALSE },
+ 	{ ID_RFC822_ADDR, ".strongswan.org", "tester@strongswan.org", TRUE },
diff --git a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
index 0769de9..5b30348 100644
--- a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
+++ b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
@@ -2,4 +2,5 @@ SRC_URI += "\
     file://tls-server-Prevent-infinite-loop-if-supported-versio.patch \
     file://pkcs5-pkcs7-Avoid-NULL-pointer-dereference-when-veri.patch \
     file://libsimaka-Reject-zero-length-EAP-SIM-AKA-attributes.patch \
+    file://constraints-Case-insensitive-matching-and-reject-exc.patch \
 "
-- 
2.34.1


