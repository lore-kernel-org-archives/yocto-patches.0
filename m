Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F019BCD5BB1
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:28:16 +0000 (UTC)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7304.1779625695150386565
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:28:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lBwfEBFs;
 spf=pass (domain: konsulko.com, ip: 209.85.222.178, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-914bd98faafso151723685a.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779625694; x=1780230494; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nH0H2wjwUgo+A6BMjQKPEtejB0FTZReqWeMu9Y6fS+A=;
        b=lBwfEBFsr4kfSvKoymAiBqkUSQjvK6kh4B+lJ2YHRkmoOhFYwV0Y0vDVXfCa7JZW6C
         y4f6sniqmDOOPRwBrvrWZrI2KafvqepLxqNEncTjHtv94FbbXOymwR9qUwZYyEpbUqz2
         FonUVt4tDYXg0E5W3rOF69ieR5erTh54LTh1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625694; x=1780230494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nH0H2wjwUgo+A6BMjQKPEtejB0FTZReqWeMu9Y6fS+A=;
        b=lk4PWq8xpayHTTAzO8yIkpo9kY+ezUEvf49sHBQbD2Pl6XUFcK1a+OM8ZJfbL5p37i
         KGTqOOMaDsnuqBDB19VHxmOPflRNT7LXQxfP4v1xO862IXUrcXD07N0KeTHPbx+5YAW1
         gU6akWsIc/8nJQT6RQzEKOxBR2mC3MZuwIwpgWnnETO6kGHT1gf8FjS340nlGqyE0a3Q
         8HCoVsUlJsA+AaONLI11QWIE7wjexTACNQws54dPd8ZkiymJOiAb7vD7GIXVxLwFbi5W
         KdJ3kvmknjM+B6iGvOhF5OHWZ91t17k8Pv9ispKHdmXrm9qF4K2I1VE1lL9zYbSZzxrm
         A52A==
X-Gm-Message-State: AOJu0YxrGEg1GG4Y9UGUwWckyCcdAtEJNhZ0+jb+k391UTVc5BeCYAPn
	44dcgJeU58R9bowJYghc2Dce+4ibaYtgL+sI2RCJgT6uiR4fjoOIvfVHgUWo7nPn/zC9z+SB0Ck
	ke4/K
X-Gm-Gg: Acq92OFcI1lIIR669oQzY/B4NW7vdGOuWKo7a9DLeX8MLFKFkCMbS1L9XIe1DvALG0y
	HSmVnmAtH82FMF66pKvaf7EjvxHIHhNnNtZelbgDzkNzV6uqGAI0xiLu5VP1ig1tWCdhXrE2hC+
	5T/S5LcbSs8IBjgLFzlJLwkfJ7kjB0/d/noD2vVJVbmPYR0+2WM8JBFjWomT5lVw0OmYcvKcTO7
	T5ElN3bu1qcrxkfJttLAPGl+ZIxIe+C/+BmzZo8Aiw60b+xiJKGQqb66TQHPmSfy0n2m4T3A5Ct
	AfNbiHe48ZHa2nxMLjLNANBrsZgwY0lg4yJGkblo7uxHM4jh1haUPpufLgv6hUZCOMs65VmJ2xy
	r89ioMIANZnoTzvTGDRCEvdBAL8JsHzLZn/N2nDCWsG9gSuT5b0/3j7FQwXffNMIp3ytNhqiFaR
	8yRmSlISLaCKD9TrEJzxlsnMtFiwpBGzvoDpbEJws68qlcy3H0ui5m/phV95vy5E1MG4hUsAEZY
	CYrL0/RF+QSuobczqCtNyxIzx738CYGqCumqZaE1ckPKHmneFHzN6jn9JGmk8rs5ZW31aMaXbc=
X-Received: by 2002:a05:620a:29c7:b0:914:bfa2:335c with SMTP id af79cd13be357-914bfa235b4mr1212414785a.33.1779625694049;
        Sun, 24 May 2026 05:28:14 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm751989385a.7.2026.05.24.05.28.13
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:13 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 07/13] parsec-service: do group membership modifications in useradd
Date: Sun, 24 May 2026 08:27:56 -0400
Message-ID: <57f8a1e92367004bffd7aaac234c1c5db0476dbf.1779625557.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779625557.git.scott.murray@konsulko.com>
References: <cover.1779625557.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:28:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4027

From: Ross Burton <ross.burton@arm.com>

Instead of calling groupmems after creating the user, we can tell useradd
to do the group membership when creating the user.  There are several
reasons for this:

1) Consolidation of the calls into a single call means creation is atomic,
   it either worked or it did not.
2) The existing logic doesn't work if both TPM and TS were enabled.
3) GROUPMEMS_PARAM is broken in oe-core master[1] and this will not be
   fixed as groupmems has been removed from shadow[2].

Instead, construct a list of groups that parsec needs to be a member of,
and pass them to useradd.

[1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=16277
[2] shadow 388ce70 "*/: groupmems(8): Remove program"

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../parsec-service/parsec-service_1.5.0.bb    | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
index c5f9978..0268c0e 100644
--- a/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
+++ b/meta-parsec/recipes-parsec/parsec-service/parsec-service_1.5.0.bb
@@ -72,9 +72,22 @@ do_install () {
 inherit useradd
 USERADD_PACKAGES = "${PN}"
 GROUPADD_PARAM:${PN} = "-r parsec"
-USERADD_PARAM:${PN} = "-r -g parsec -s /usr/sbin/nologin -d ${localstatedir}/lib/parsec parsec"
-GROUPMEMS_PARAM:${PN} = "${@bb.utils.contains('PACKAGECONFIG_CONFARGS', 'tpm-provider', '-a parsec -g tss ;', '', d)}"
-GROUPMEMS_PARAM:${PN} += "${@bb.utils.contains('PACKAGECONFIG_CONFARGS', 'trusted-service-provider', '-a parsec -g tee', '', d)}"
+USERADD_PARAM:${PN} = "\
+    --system \
+    --gid parsec \
+    --shell /usr/sbin/nologin \
+    --home-dir ${localstatedir}/lib/parsec \
+    ${@parsec_groups(d)} \
+    parsec"
+
+def parsec_groups(d):
+    groups = []
+    config = d.getVar("PACKAGECONFIG").split()
+    if "TPM" in config:
+        groups.append("tss")
+    if "TS" in config:
+        groups.append("teeclnt")
+    return "--groups " + ",".join(groups) if groups else ""
 
 FILES:${PN} += " \
     ${sysconfdir}/parsec/config.toml \
-- 
2.53.0


