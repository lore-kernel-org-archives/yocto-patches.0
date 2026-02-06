Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129D2EE6B65
	for <webhook@archiver.kernel.org>; Fri,  6 Feb 2026 21:25:32 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1430.1770413123667654367
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 06 Feb 2026 13:25:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=YXc0qHwz;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6f21c2d81so254476785a.2
        for <yocto-patches@lists.yoctoproject.org>; Fri, 06 Feb 2026 13:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1770413122; x=1771017922; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTYUhHI3RgHvLBFa94pSuuLtBhTW7RWXp/YHAVpHTMk=;
        b=YXc0qHwzqn7yiz9x7MytFi8zCNhaq2Zx++Ydp6JgCTxKsE4MUuujmfwNBtUevmxwAs
         XUw1HLHObaC/SyMf8qjm+SIFBuVjKPNOyUC2RQOQduSCkiD2saHO+iYhxCRjWoynpEks
         th7nseA3kvWissR8AN8QdV7wf2UBJZmXZwnek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770413122; x=1771017922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DTYUhHI3RgHvLBFa94pSuuLtBhTW7RWXp/YHAVpHTMk=;
        b=Ng+EciFI07KRfkVs8MgdMsjPOWgljQPpsS2Qud4O8hVWUbM4rG/nVkUFEIs7aqFcsl
         CEEgCR1Vx4oCT/PnfQbafJZjE9lAB/GbFfRZRHgqjV13PpLhT/f/IdcBs00eFcj3Wtqs
         K8JVT+t8jZoUykwppDR0rPOigsMkaO+Lmqhs/8oeTlJGSnCpFPeRTGGz7m5V3trdz1Jb
         +Fx8utifX4Wu0M8sh7ya2xfjDjpiq+verdC35KOlXxdd6hrxvJ9O1cEEiUFXpZSPKu0G
         eHD6J568PNsIsF2LkqssChkfyVDwlq/mh5Tuh/0i1DmHTsvzoNmqLupJILZxwTMiAh26
         0W5A==
X-Gm-Message-State: AOJu0YycFSIMw7y9ENvybmrJtPgy+JfAmmXaVjOggKigDEgCysmeOrcN
	3xLhb4XLdYGY02rJ5e+H3argsfBGmjC9cy9aHlrg6DTp7bJdHl+q+oUvdpmZ1h3Io5G33D4xCOE
	Bjg44
X-Gm-Gg: AZuq6aIxIoG8RWhU9k+8BDQ+6vEdbyCY7qVw6+ndh/V6j2tE9dEBkYAs+xWMKLagRLp
	v5LcpX7XQmcGOkfc/oIFQb+nNaOwHL6x9yDMM67VzZROBczOi0zXLI7ynreAgHYqk8kR7o6rxol
	pqzWqRydJPI36ppIUA3D1IIU3THzoPyuuclnazzQ4rl+TbPcmOAa557fB81xH4SXRYFeAFhd/HM
	JaIhGVSQJ+BrXvmMlixV+1jRvavVAPiA3ScvIVwXxKhH3+sxJ/WZJPlrBkYGQJoFDO2O9ciO+o6
	wQPc9k+sv+Yyk8dv9Z9fOoubJVIDcx2lRNXCOUlx6wPCTFbqUCeeRA0a4iNaj3CctDc9palRdhP
	AjIBcfagJx2oxMOiNGAQkL/BGGVmSDgyafZOFIjiM66HjZiJmjpI9eD3I62fowfH3hgUXpGoC1D
	A51qRzCfs87SlLfpSBsSszAiklU+NQkj5x6f83rezWfAXNOtkAp7euNX2085btUnU4ERTmQsWF2
	6fGLeeYZ0ttKf/k4ck/K2t/VoQR5VIoAyYP42uOgvFfPmD6djL3
X-Received: by 2002:a05:620a:1789:b0:8c6:a64e:928d with SMTP id af79cd13be357-8caf26913f8mr540314785a.83.1770413122382;
        Fri, 06 Feb 2026 13:25:22 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf77f6f05sm241509385a.1.2026.02.06.13.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 13:25:21 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Zahir Hussain <zahir.basha@kpit.com>,
	Nitin Wankhade <nitin.wankhade333@gmail.com>,
	aszh07 <mail2szahir@gmail.com>
Subject: [meta-lts-mixins][kirkstone/rust-1.75][PATCH 1/1]  rust-cross-canadian: Ignore Windows CVEs
Date: Fri,  6 Feb 2026 16:25:13 -0500
Message-ID: <000b0fb2161591a4e71bf7b37a3031e30ca85c4f.1770412335.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1770412335.git.scott.murray@konsulko.com>
References: <cover.1770412335.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 06 Feb 2026 21:25:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3198

From: Zahir Hussain <zahir.basha@kpit.com>

Ignore CVE-2024-24576 and CVE-2024-43402 as they are not applicable
for Linux; the CVEs are specific to Microsoft Windows.

The previous change to ignore these in rust-source.inc did not cover
rust-cross-canadian, so add them to rust-cross-canadian.inc to fix
this.

CVE: CVE-2024-24576
CVE: CVE-2024-43402

Signed-off-by: Zahir Hussain <zahir.basha@kpit.com>
(added CVE-2024-24576, updated commit message)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-cross-canadian.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/rust-cross-canadian.inc b/recipes-devtools/rust/rust-cross-canadian.inc
index 45cb402..6d758b7 100644
--- a/recipes-devtools/rust/rust-cross-canadian.inc
+++ b/recipes-devtools/rust/rust-cross-canadian.inc
@@ -90,3 +90,5 @@ do_install () {
 
 FILES:${PN} += "${base_prefix}/environment-setup.d"
 
+# These CVEs are specific to Microsoft Windows
+CVE_CHECK_IGNORE += "CVE-2024-24576 CVE-2024-43402"
-- 
2.51.0


