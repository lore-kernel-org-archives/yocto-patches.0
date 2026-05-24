Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85042CD5BAB
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:28:28 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7246.1779625698893551720
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:28:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=JnsjBe/o;
 spf=pass (domain: konsulko.com, ip: 209.85.219.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b6dd874471so133123636d6.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779625698; x=1780230498; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KG3fqPPh9IbFdsP+TWH4RiDpILV0ygthFmsSLpMbxxA=;
        b=JnsjBe/oCXg24G1d4VgtnWy18HhJgO0kZtT/ZQ5GOAuvVgvvw+8VEXnHs6RIxfl4sn
         VivvqXwUE7p5Kj1YxuzlnJ3YzqZBqUSSW8awn2ufyr+LQfNe4jaMXalOR4RdkoEVhf5N
         nLfnnrjbSY4bTW6YICj/NidAHE8rZue/88wxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625698; x=1780230498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KG3fqPPh9IbFdsP+TWH4RiDpILV0ygthFmsSLpMbxxA=;
        b=PGU78ZTfjsVAEi8bk1ptPwja2rDU1KWuEuZHNBUbDNlY9sXeuXjoD64/xs4LHD8M5A
         IOZPRxBYB97wzaVIz7ewqgyRyLlKViKzM7XfcII+hSmV5qL11lWKTVvbwVpQjlmGPZ3Y
         oipU55K7ON808FIreykz20GeDNYbCw/TccwWiG2piMCdBqjCl0aC/n6CmWkKeJf549R7
         1kdKvls664raD2wM2gfgLqN+OE/Ebmsmj64mkyK2bTlZZsk9TGUcDSAz4VlemjnSlzhV
         93o6Qeuwu9n9Z08v2m13wmBxc9qlsJwbCr2ngvUm1KaHQifrdTlQTuI91BLzVLlZF5sU
         xVmg==
X-Gm-Message-State: AOJu0YzWu2oAV9vQ57sMu6SJsY6TVbRs1Xt3ZJlMyeQPfoi+Bft8IK2e
	Hwu4lrIm5Mw/YmuuL6w7y42PzCRAfs15X0SQ+4j4YFMaWx9rspQEkQx1PLqcEPCDovV+PbVJhUy
	aKaxa
X-Gm-Gg: Acq92OGHHu4bnEt/qxRHzwgjotIRMTofpcc6VHCbjw4miVrjn46BIbG3TI/UDnQbjY+
	WBBWqS3oLEsDigqMwcpfr5K6OdL2B9UrI+FF75MTEmK9zgbJo/fC4mE/zPCjf4mFg1+xbd+nUNn
	hqdp/2n6H/V/fH3EwnV7snJPLERnunkgLQCFaq3G+bwPWiy/bha9ERmCnq3yA/QwjQy+vOZ1peG
	NepJc08lJ58Jlu4VFd7p/VNJuo5Fk6MOg18Ay61/3jbpGKM7GI/PdvyScTsz/cnfB0FtN3ag074
	AtIRHMD7bJh2UM4cNpUgipCjWjCXBuoL3kHcXigp7csCvItCCqmiRxPyDWAuKF5sJnppu1DWKrO
	1Cp5HjWgiVV9CfoUwu2egbbO8bd5/9Cni5X6kOZX8VToByYbSNPZPV1yUi2zN9aRIlhDzyVjB+L
	rd58+8A9g/0q225xncTKvFZIZAiqabtdI0FilAMNw9qL/Ie+JGZ0mEjLRjW7Pg0KlmlTczDmptX
	j4WvKxADxyzvxn/LWxsKfdYo7jfyBrZU57Ka8PWId5Df/Gz4lHWLn6i68b27/Ex
X-Received: by 2002:a05:620a:254a:b0:8cf:c451:cc1c with SMTP id af79cd13be357-914b49d2121mr1561357585a.58.1779625697864;
        Sun, 24 May 2026 05:28:17 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm751989385a.7.2026.05.24.05.28.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:17 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 13/13] samhain: upgrade 4.5.2 -> 4.5.3
Date: Sun, 24 May 2026 08:28:02 -0400
Message-ID: <f7d6b118f6e2a1bccc6b863584ca25ba74021c46.1779625557.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779625557.git.scott.murray@konsulko.com>
References: <cover.1779625557.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:28:28 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4033

From: Bin Cao <bin.cao.cn@windriver.com>

Update samhain-client, samhain-server, and samhain-standalone to 4.5.3.

Release notes: https://www.la-samhna.de/samhain/archive.html

Signed-off-by: Bin Cao <bin.cao.cn@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-ids/samhain/samhain.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-ids/samhain/samhain.inc b/recipes-ids/samhain/samhain.inc
index fc4e423..95413cb 100644
--- a/recipes-ids/samhain/samhain.inc
+++ b/recipes-ids/samhain/samhain.inc
@@ -3,7 +3,7 @@ HOMEPAGE    = "http://www.la-samhna.de/samhain/"
 LICENSE     = "GPL-2.0-only"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=8ca43cbc842c2336e835926c2166c28b"
 
-PV = "4.5.2"
+PV = "4.5.3"
 
 SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://${INITSCRIPT_NAME}.init \
@@ -22,7 +22,7 @@ SRC_URI = "https://la-samhna.de/archive/samhain_signed-${PV}.tar.gz \
            file://0001-Format-test-output-to-match-Automake-standards.patch \
            "
 
-SRC_URI[sha256sum] = "0b5d3534fd60ecf45dfd79bd415e81f7a56eba7f1755771735e204f334033578"
+SRC_URI[sha256sum] = "e7837adfde3d59a23c59e1bf3ebacdf71bce018619194cfad938cd30cbb9d15b"
 
 UPSTREAM_CHECK_URI = "https://www.la-samhna.de/samhain/archive.html"
 UPSTREAM_CHECK_REGEX = "samhain_signed-(?P<pver>(\d+(\.\d+)+))\.tar"
-- 
2.53.0


