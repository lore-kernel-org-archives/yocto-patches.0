Return-Path: <nitin.wankhade333@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1265CCD4F26
	for <webhook@archiver.kernel.org>; Tue, 23 Jun 2026 06:10:27 +0000 (UTC)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14972.1782195026494221702
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 22 Jun 2026 23:10:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=gQJgLVfM;
 spf=pass (domain: gmail.com, ip: 209.85.216.43, mailfrom: nitin.wankhade333@gmail.com)
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36f4773d7abso773117a91.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 22 Jun 2026 23:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782195026; x=1782799826; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjYlRqrvgwYSRsgZ9XK2s173v8uo48A6fjvELvf36bU=;
        b=gQJgLVfMnmMxjW5VuEdzeRx47QP3Pw0f6S58wxWF8HVqdd+XoAakCI1FZuwqeasXVv
         GgonWPGRecyu2Z9RXZcPfFfGjrvfolLLb+d9pXKccttFOoOkq92n6lrO+o5woor3lkKp
         AXbDs6XVKkSWAzE1u9iyebNH9xAvnPM9Di4ikCxSSuYRUqGfrKcqTMKxhAHg5XoDNkg5
         kdZm4q+XVUML1Wpr1ZPXsSblqzdOYHwJg3xyib6CLOB7eOGMEsWpXEBDZZ6sSeV0gId+
         I/EYNbWhnJEfGZ8VpYlEx/hjRLuHXM+iB2D87FQUfG/F+Qw1HX0qw8TWDLkiKWt5/Cr1
         y84g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782195026; x=1782799826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QjYlRqrvgwYSRsgZ9XK2s173v8uo48A6fjvELvf36bU=;
        b=MvYRqAcgRWAAdudQDatXyqAUlkW4Zz6dVmGc+hF6JQlVoo3FQNOUsnAT6wT01Y49tl
         +MbcNI5bRc+r6mGIdfN3JOWwajEKu4GtP3yoZaXDqv2SY8pRMkM8uplfVziJhChRXp7Z
         yBL1QIcR6zuj9OVMVhfmol/ht8f2JPUFrJhbiSV2CTJUhYx5cgC3OybheEBA381zkYQ6
         TsYP6G206fLvjAFphzYRPdHQWUIaLhIOoWFCub1keX2JniewLnxmUoqLcq1i/ZEB14o9
         /RrLmc1yc94PrTVggzCuLU5eKVgqvJFdFVh0voo1fED7HHwMuLM7s2Of+VF3hXz/+KkS
         ErCg==
X-Gm-Message-State: AOJu0YyNAgHCaJsIyXfnTsWyAnMmYOrVu84/acFxNwKLO5EpGd55KMX+
	Zego9MYWiaBn+keHBtG9QkXhwUhffJYyFw6fVmVR1L28PzduJG8eqQwlbmA/weAY15Q=
X-Gm-Gg: AfdE7cl6ff73499Q4+QOZQGv60hWxxuyso6EjfJhzqgxL8vBo0h2W4dCY5oFdhz8xnw
	THExulVDc5dQXFlBI7pI5IR4Xx58IbvDSwszeiySZ9RfLoxtEfg1wNHhbdpKd7TokHYPOvqOaTz
	nyahuRh7YqqMpufzonCETO5GNW4VK26jLhJIeMMBii8Dlgu9KKOllxBNQIvf1FVFtvXHnUp4q6i
	5fiG78UlYAa/rulPSDVSMYMU1ZNm0fDJ3egdCRgWl1qoTqfRDOlkRhZNQQ9uAJEJMLQDNqbHblZ
	W/dCSOsQHUh+8zETlsbCG9dBkDSjbIC1lWpXcpSIFYBivWT6dUdl7TSrUZBLgoA1ya3i0G4UNdL
	RYDt+Z+EbaCXHqHcdUumdemXlb1NIuo5mwx8Zs1TTHiE/saFDA+3P037V2a7Nm0MvbxyBqs0UVH
	4LWOuJlod8RDheP7dFpyxfx/I=
X-Received: by 2002:a17:902:f651:b0:2c0:c965:6656 with SMTP id d9443c01a7336-2c7bf1d6ab6mr17222955ad.6.1782195025767;
        Mon, 22 Jun 2026 23:10:25 -0700 (PDT)
Received: from LL-868L.kpit.com ([49.206.129.123])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f85f1sm99844045ad.42.2026.06.22.23.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:10:25 -0700 (PDT)
From: Nitin Wankhade <nitin.wankhade333@gmail.com>
X-Google-Original-From: Nitin Wankhade <nitin.wankhade@kpit.com>
To: yocto-patches@lists.yoctoproject.org
Cc: nitin.wankhade@kpit.com,
	Nitin Wankhade <nitin.wankhade333@gmail.com>
Subject: [meta-lts-collab][kirkstone][PATCH V2 4/7] strongswan: Fix CVE-2026-35331
Date: Tue, 23 Jun 2026 11:39:58 +0530
Message-Id: <20260623061001.644583-4-nitin.wankhade@kpit.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623061001.644583-1-nitin.wankhade@kpit.com>
References: <20260623061001.644583-1-nitin.wankhade@kpit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Jun 2026 06:10:27 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4270

From: Nitin Wankhade <nitin.wankhade333@gmail.com>

Upstream-Status: Backport [https://snapshot.debian.org/archive/debian-security-debug/20260422T125423Z/pool/updates/main/s/strongswan/strongswan_6.0.1-6%2Bdeb13u5.debian.tar.xz]

Signed-off-by: Nitin Wankhade <nitin.wankhade333@gmail.com>
---
 .../strongswan/files/CVE-2026-35331.patch     | 157 ++++++++++++++++++
 .../strongswan/strongswan_5.9.13.bbappend     |   1 +
 2 files changed, 158 insertions(+)
 create mode 100644 meta-networking/recipes-support/strongswan/files/CVE-2026-35331.patch

diff --git a/meta-networking/recipes-support/strongswan/files/CVE-2026-35331.patch b/meta-networking/recipes-support/strongswan/files/CVE-2026-35331.patch
new file mode 100644
index 0000000..13a8954
--- /dev/null
+++ b/meta-networking/recipes-support/strongswan/files/CVE-2026-35331.patch
@@ -0,0 +1,157 @@
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
+index 3672912..9a25eb6 100644
+--- a/src/libstrongswan/tests/suites/test_certnames.c
++++ b/src/libstrongswan/tests/suites/test_certnames.c
+@@ -194,8 +194,10 @@ static struct {
+ 	bool good;
+ } permitted_san[] = {
+ 	{ ID_FQDN, ".strongswan.org", "test.strongswan.org", TRUE },
++	{ ID_FQDN, ".strongswan.org", "test.strongSwan.org", TRUE },
+ 	{ ID_FQDN, "strongswan.org", "test.strongswan.org", TRUE },
+ 	{ ID_FQDN, "a.b.c.strongswan.org", "d.a.b.c.strongswan.org", TRUE },
++	{ ID_FQDN, "a.b.c.strongswan.org", "d.A.b.c.strongswan.org", TRUE },
+ 	{ ID_FQDN, "a.b.c.strongswan.org", "a.b.c.d.strongswan.org", FALSE },
+ 	{ ID_FQDN, "strongswan.org", "strongswan.org.com", FALSE },
+ 	{ ID_FQDN, ".strongswan.org", "strongswan.org", FALSE },
+@@ -203,6 +205,8 @@ static struct {
+ 	{ ID_FQDN, "strongswan.org", "swan.org", FALSE },
+ 	{ ID_FQDN, "strongswan.org", "swan.org", FALSE },
+ 	{ ID_RFC822_ADDR, "tester@strongswan.org", "tester@strongswan.org", TRUE },
++	{ ID_RFC822_ADDR, "tester@strongswan.org", "tester@strongSwan.org", TRUE },
++	{ ID_RFC822_ADDR, "tester@strongswan.org", "TESTER@strongswan.org", TRUE },
+ 	{ ID_RFC822_ADDR, "tester@strongswan.org", "atester@strongswan.org", FALSE },
+ 	{ ID_RFC822_ADDR, "strongswan.org", "tester@strongswan.org", TRUE },
+ 	{ ID_RFC822_ADDR, "strongswan.org", "tester@test.strongswan.org", FALSE },
+@@ -232,11 +236,11 @@ static struct {
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
+@@ -266,7 +270,9 @@ static struct {
+ } excluded_san[] = {
+ 	{ ID_FQDN, ".strongswan.org", "test.strongswan.org", FALSE },
+ 	{ ID_FQDN, "strongswan.org", "test.strongswan.org", FALSE },
++	{ ID_FQDN, "strongswan.org", "test.strongSwan.org", FALSE },
+ 	{ ID_FQDN, "a.b.c.strongswan.org", "d.a.b.c.strongswan.org", FALSE },
++	{ ID_FQDN, "a.b.c.strongswan.org", "d.a.b.C.strongswan.org", FALSE },
+ 	{ ID_FQDN, "a.b.c.strongswan.org", "a.b.c.d.strongswan.org", TRUE },
+ 	{ ID_FQDN, "strongswan.org", "strongswan.org.com", TRUE },
+ 	{ ID_FQDN, ".strongswan.org", "strongswan.org", TRUE },
+@@ -274,6 +280,7 @@ static struct {
+ 	{ ID_FQDN, "strongswan.org", "swan.org", TRUE },
+ 	{ ID_FQDN, "strongswan.org", "swan.org", TRUE },
+ 	{ ID_RFC822_ADDR, "tester@strongswan.org", "tester@strongswan.org", FALSE },
++	{ ID_RFC822_ADDR, "tester@strongswan.org", "TESTER@strongswan.org", FALSE },
+ 	{ ID_RFC822_ADDR, "tester@strongswan.org", "atester@strongswan.org", TRUE },
+ 	{ ID_RFC822_ADDR, "strongswan.org", "tester@strongswan.org", FALSE },
+ 	{ ID_RFC822_ADDR, "strongswan.org", "tester@test.strongswan.org", TRUE },
+@@ -304,7 +311,7 @@ static struct {
+ 	char *subject;
+ 	bool good;
+ } permitted_dninh[] = {
+-	{ "C=CH", "C=CH, O=strongSwan", "C=CH, O=strongSwan, CN=tester", TRUE },
++	{ "C=CH", "C=CH, O=strongSwan", "C=CH, O=strongSwan, CN=tester", FALSE },
+ 	{ "C=CH", "C=DE, O=strongSwan", "C=CH, O=strongSwan, CN=tester", FALSE },
+ 	{ "C=CH, O=strongSwan", "C=CH", "C=CH", FALSE },
+ };
+@@ -334,7 +341,7 @@ static struct {
+ 	char *subject;
+ 	bool good;
+ } excluded_dninh[] = {
+-	{ "C=CH, O=strongSwan", "C=CH", "C=DE", TRUE },
++	{ "C=CH, O=strongSwan", "C=CH", "C=DE", FALSE },
+ 	{ "C=CH, O=strongSwan", "C=DE", "C=CH", FALSE },
+ 	{ "C=CH", "C=CH, O=strongSwan", "C=CH, O=strongSwan, CN=tester", FALSE },
+ };
diff --git a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
index 527e3b3..b5d1966 100644
--- a/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
+++ b/meta-networking/recipes-support/strongswan/strongswan_5.9.13.bbappend
@@ -3,4 +3,5 @@ SRC_URI += "\
     file://CVE-2026-35328.patch \
     file://CVE-2026-35329.patch \
     file://CVE-2026-35330.patch \
+    file://CVE-2026-35331.patch \
 "
-- 
2.34.1


