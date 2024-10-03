Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981E5ECE572
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 11:30:23 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
 by mx.groups.io with SMTP id smtpd.web11.9209.1727955021714969515
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 03 Oct 2024 04:30:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=S0Uh+yvi;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.167.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398e3f43f3so1013870e87.2
        for <yocto-patches@lists.yoctoproject.org>; Thu, 03 Oct 2024 04:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727955019; x=1728559819; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t126v37KmmzXvEpAokIaoobNo9nwMQCUdp2uiTlE2LI=;
        b=S0Uh+yvia/j0XPaTCjkkOII0uyGRyOWk/C1wASbK/cx0tDU89kqdLHzp/wrcUxEMSS
         sGEIzssAEjvlZztro4rAeOBBRQJ+RPxcuyAKAefc6EaVAmP/kpPByNxf1l41Vztu9Fnu
         CIhyEmYUshXGUonAWtthw/KKVmTp+Eaxi3k5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727955019; x=1728559819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t126v37KmmzXvEpAokIaoobNo9nwMQCUdp2uiTlE2LI=;
        b=UdAjyB8KPPEdjysswSRIml+je5+CCAKAackW4rL651uC1uoi39l3i+RYC78xJTLJ/R
         n/Hwnm8YmH9+tZ3QYbYFS7BmpDyvlAU3HdhtrYiChsY0X/fuQkvduqEo5t8/3J0efUdv
         1FANVjCan6EhfgEqreIgno/rSGk4dGkfa6raEXbQV32mOJBvQp2juNuVN6QtcMBNu+ac
         Mq9Mz3SX9eYXtpDT85K0pyNf2gYkWpMN/LuiR+BaFNs5iHJGWrD3TcMwgneN3s5UBUIm
         CJxOldpHYw/vC0C4spmiDSTlySsLhLYIGl/TkwNgUVbey7T7qsc0K1GY2YTq+IByTchX
         fdWw==
X-Gm-Message-State: AOJu0YxgoW8gtUkd42pdWzzLy3eKYoDlQIadXhzogPslNv36oexAGEOA
	t42zatW+5hCN3soEf495oOeoSVcHUubSgwviC+iM5m+pcYV2S7JlNKRmNxvFcR5C0rCtuSL8qAl
	E
X-Google-Smtp-Source: AGHT+IHr3cKpmu/OIT8kDJaRhKbUKmAEhO7lyr4in1qRiGE7HESkSZvHS7I8m8G9DAuo3wvjRUTWvA==
X-Received: by 2002:a05:6512:3b27:b0:536:7b56:6b90 with SMTP id 2adb3069b0e04-539a07a3629mr3792780e87.56.1727955019422;
        Thu, 03 Oct 2024 04:30:19 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:cae3:f165:6194:3295])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f8026567fsm13370075e9.26.2024.10.03.04.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 04:30:19 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [PATCH 1/2] pseudo_util: Fix null pointer dereference for null envp
Date: Thu,  3 Oct 2024 12:30:17 +0100
Message-ID: <20241003113018.3531433-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 03 Oct 2024 11:30:23 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/686

Whilst not recommended, the kernel does accept NULL values for envp when
passed to execve and posix_spawn. Avoid pseudo_setupenvp segfaulting
when such a value is passed in and instead handle it correctly.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 pseudo_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pseudo_util.c b/pseudo_util.c
index b58036f..24115ff 100644
--- a/pseudo_util.c
+++ b/pseudo_util.c
@@ -1051,7 +1051,7 @@ pseudo_setupenvp(char * const *envp) {
 	free(pseudo_get_libdir());
 	free(pseudo_get_localstatedir());
 
-	for (i = 0; envp[i]; ++i) {
+	for (i = 0; envp && envp[i]; ++i) {
 		if (STARTSWITH(envp[i], PRELINK_LIBRARIES "=")) {
 			ld_preload = envp[i];
 		}
@@ -1113,7 +1113,7 @@ pseudo_setupenvp(char * const *envp) {
 
 	free(libdir_path);
 
-	for (i = 0; envp[i]; ++i) {
+	for (i = 0; envp && envp[i]; ++i) {
 		if (STARTSWITH(envp[i], PRELINK_LIBRARIES "=")) continue;
 		if (STARTSWITH(envp[i], PRELINK_PATH "=")) continue;
 		new_envp[j++] = envp[i];

