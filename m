Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F626CD5BAB
	for <webhook@archiver.kernel.org>; Sun, 24 May 2026 12:28:17 +0000 (UTC)
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7298.1779625691128057943
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 24 May 2026 05:28:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=miwhllwt;
 spf=pass (domain: konsulko.com, ip: 209.85.222.171, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9102e90bcbeso936875385a.1
        for <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 05:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1779625690; x=1780230490; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vjgEv1TTEJQV513bNSK6N9EOPJsM0CArvbqQfw1cdgE=;
        b=miwhllwtr1aplJrbk1/elxjyk3WY/JLA2JhAdnQpXBdbQxZ0AaDyV743Ur55zOZtoL
         HyMSWvB5XTQSjYVw6GwitF2psoDU6HL+QyL27Tr1aZceLokYxuDUNTgpbQCE4HTbpD1O
         sRWwgG2DlKGIE2Vpf6ewXbKkCJjm0wzYYypCY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779625690; x=1780230490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vjgEv1TTEJQV513bNSK6N9EOPJsM0CArvbqQfw1cdgE=;
        b=FkoSv7bKLCg3SW4ZIvjRErGr9myrpXkaW1Ii9lTUkxtqKkM9MVKb5ZpfahjYLY5Xdo
         2q50/DuhjyR42bfJp1tkzQa8SPINaNLDG9jiW5Nk33az+HDjzyuJBGtfG8unwPGN1DSi
         p3w4DImdldS+gPz/Gjb4+amTUj41yC1/wwOY7QBrONWI1Y0WDZbIdNIVBY+3duHQmOx9
         jBbNyCwwY9AdsNc32u8YGnVlTdwFs0DPaklXgIdzYC5dfoTOUyTRwIaMHduM3Yvu2Msk
         X27VE10dy3DzbLygopAVejPlU5WGOkwcFnb9/zehfGg+Z0dtvswunRcqfR/711gu7etb
         3HVw==
X-Gm-Message-State: AOJu0YzBXQM6D1HtXjtoZs5xiGI+vxrVQdBvSu3NvV8Ve+bGDgUiAoGs
	dQJXS+MTmsqteyU+iL1BAaYZGN6MPoFx0A2rjGdOqmJagWDs/VebKNiK7LfStYtcxATKNJSrVce
	gY/t8
X-Gm-Gg: Acq92OFF6XFgjZM4y4OMATcUVgs1DdW2V1FGCB9uhc6amyh/+pi3hROmoMorF6HXklm
	8WOf79ZYzxkAzd0kZhpZElR0D9aUIpOiuHem42DcE74XanOYNOHZP7qLhbFMg+cA8XOCPcfmqKu
	dRDHpuReFXGTfDU16B3R+ao+OzP/7eYvam9EV9NJDQDJhpfUCSDyDP3rwA86yz+ckGLOmqAVf4U
	LOPyssNabY22z1h2fWEkILQ4txeK62+AtqR8Ss1n28jDdOWbvi0EF9AA0zH478hY87he4z2aOpg
	Zzw6sPe9/Q5p9sISQaca9ARGqkGH6TWEwhsROF/FfUYj+OTi3wUro19SDSJlWZ0yRI429YIz1PC
	aK6dxoarzziSV7fXQAWE9PJYRsC0SJtiGS+a6gV8NzOjen0Hy9RHlhQaH92stNuhf/DykBG1C0a
	mK44pAxYtH42TJd5vBdDMG8B92HUuYAWHaT1HtRKd/44UId9d/4yKNjKYnPA5Kf07TCWpUMzpAf
	7XZl9px5Yq7fyMYx5tqpJQVp5yNShStRflNSsyBWa5w03GomzpDG+HHKrVUTCZp
X-Received: by 2002:a05:620a:2944:b0:914:c8aa:34d5 with SMTP id af79cd13be357-914c8aa3bd2mr713002985a.56.1779625690001;
        Sun, 24 May 2026 05:28:10 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914bb8c8034sm751989385a.7.2026.05.24.05.28.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 05:28:09 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 01/13] firejail: fix COMPATIBLE_MACHINE setting
Date: Sun, 24 May 2026 08:27:50 -0400
Message-ID: <a289f2287818930a3386401db529a6b01f7bde20.1779625557.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779625557.git.scott.murray@konsulko.com>
References: <cover.1779625557.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 24 May 2026 12:28:17 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4021

From: Li Zhou <li.zhou@windriver.com>

Because "x86_64" and "arm64" aren't valid in bitbake OVERRIDES,
they should be corrected to "x86-64" and "aarch64".
On the other side, "x86_64" and "arch64" aren't valid MACHINE
name.
So correct the way to "only allow x86-64 and arm64 to build":
COMPATIBLE_MACHINE = "(-)"          => disallow all machine first
COMPATIBLE_MACHINE:aarch64 = "(.*)" => when arch "aarch64" in
OVERRIDES, allow all machines.
COMPATIBLE_MACHINE:x86-64 = "(.*)"  => when arch "x84-64" in
OVERRIDES, allow all machines.

Fix 1dd076d3a76f ("firejail: only allow x86-64 and arm64 to build")

Signed-off-by: Li Zhou <li.zhou@windriver.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-security/Firejail/firejail_0.9.72.bb | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/recipes-security/Firejail/firejail_0.9.72.bb b/recipes-security/Firejail/firejail_0.9.72.bb
index cf0190d..746f788 100644
--- a/recipes-security/Firejail/firejail_0.9.72.bb
+++ b/recipes-security/Firejail/firejail_0.9.72.bb
@@ -57,7 +57,8 @@ pkg_postinst_ontarget:${PN} () {
     ${libdir}/${BPN}/fseccomp memory-deny-write-execute ${libdir}/${BPN}/seccomp.mdwx
 }
 
-COMPATIBLE_MACHINE:x86_64 = "x86_64"
-COMPATIBLE_MACHINE:arm64 = "arch64"
+COMPATIBLE_MACHINE = "(-)"
+COMPATIBLE_MACHINE:aarch64 = "(.*)"
+COMPATIBLE_MACHINE:x86-64 = "(.*)"
 
 RDEPENDS:${PN} = "bash"
-- 
2.53.0


