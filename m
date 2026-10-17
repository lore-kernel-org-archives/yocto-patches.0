Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4930CCF2C1
	for <webhook@archiver.kernel.org>; Sat, 17 Oct 2026 17:36:22 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.972.1792258578542065065
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 10:36:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=YQCV42F+;
 spf=pass (domain: gmail.com, ip: 209.85.214.174, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9d1114320so461045ad.3
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 10:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792258578; x=1792863378; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2oQ7H/3hNO4kerHNIbmhMF0ANJIrv//Ve9G5oIBnIgE=;
        b=YQCV42F+PZePLue0n+DHaQdf7Fby01qjEtnwznPuGut8DFfylgIcPs3xsMwYyXQqeg
         wwYTnsiArPPBtc4wbuede9dkVx85CuBBOaJDHLAUnQ2Y/Pu98u8jZBnjIs1x9Gc9Pc+E
         jrSb1uqAmSwiJI7n/I7P8D3qNiQsIg1hWxclmhinVise6quMaue1VIhvezLM/L9mkU4h
         QP50QG7hiO6U4UE4MBEXKAB8LARaJnswSqzE63suO2Hm5FoYMvxtVqEMINO+/0cLY8dM
         AYarEH+0/AvC8E+ylo0FlNa+By2Am56xX5opCGPTdkGE6gyz+g9bO+33vDoC3mHqXdPd
         oPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792258578; x=1792863378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2oQ7H/3hNO4kerHNIbmhMF0ANJIrv//Ve9G5oIBnIgE=;
        b=lisacxMaKg/HMfFqxvABLHL8KcKwmBqHW379PT8j/N8HBIKlBqPeVnPZUSEAsWslKb
         25URqVuktXa0W5ub57lNVoZAX9KamcZqaBrEMiwluNIx/oo49AbBJwkEJlburldjHn7V
         Auch9rXYQhksrvGMqMwt9RA/wQ5Sj8l+hq2Q7jul4B6UWFoj1mhEQSnbDGj7619NTWb6
         F1be5LvuuljuzpUUeygW/j8kYo6Waed8ilM3w05AbJ+8q1jjTMvVfg6TY4k8RWvbfSch
         Zsxg+9BQkgpYeqZlFwnsMtWUQWr2OpyWyFsyQaZn0zElLGMRmyxnKwshXH2kEO804B/5
         bzbg==
X-Gm-Message-State: AFq9FYK/VkFvKLI5awoc72SHeJezxPQwJC5kWrk6reZGYEzvv6/3mNqD
	Mu/Gh3bcAYuWTlw28KqbiAwD6jiLSBEIfm/bAj4/rkwVSUmBHEztVUCKpa8qMQ==
X-Gm-Gg: AYBFou30pK8f5OKvzihdtiU7qQBpLP2KG/gYOUVhDCIG1LlL//tguNbsKtPsqNhunT6
	SdYWC8CsqZpIsn+cMpXSpRGtZhM6JPAp+JKHleFCprBilinLk5fRXiFy9KzUaOcN9oGFRvmR5Mt
	+u0wgppO/zPXaERXGKrNhRYSGh0lKgBSbSmkavoI97U2GeYk9hKbox6ZgIk8DPygIgmhmXqk9lc
	iv39TwnOZwKDFPuO8IA2MvRJ85ihXj371/ZzDuCf5hKVxToKJiJbGqx/Hx/DXVltYF9HS4vXNZB
	iWaL8xc45MHsZ4oiJEo9uL6ToY9impqVJnxHgOCNIrZHvOOl+zxMbhkGURLi/MNu09xE8HajEix
	xs1FO6xKziY8RnphA3QsA23lRneLsHuN8asAbZH3doWBTfDgae6FXrEZZaqZzQVWGCj8s0dKcsP
	5f7LABqccthT1E82aVIfwtvb2vwnVVPnQATLSyDdsIUxlMWf3hl1uBvpp9ykQDK9+tUq973jxnc
	V4V7noFab9jAvjx/dR4rvXAPiH3m3U=
X-Received: by 2002:a17:90b:57c3:b0:3a8:6045:5a19 with SMTP id 98e67ed59e1d1-3aceec60801mr2940952a91.37.1792258577594;
        Sat, 17 Oct 2026 10:36:17 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac943e7548sm13988334a91.1.2026.10.17.10.36.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 10:36:15 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [layerindex-web][PATCH] requirements.txt: fix GitPython and Django vulnerabilities
Date: Sat, 17 Oct 2026 10:36:08 -0700
Message-ID: <20261017173608.79592-1-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 17:36:22 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5039

GitPython 3.1.59 -> 3.1.62 resolves Dependabot alerts #60-63
(GHSA-239g-whfq-7xj9, GHSA-g5vv-9gxw-82hx, GHSA-whh4-5q6c-9v3x,
GHSA-59cr-6r3x-644w).

Raise the Django floor to 5.2.18 to avoid five issues affecting
>=5.2,<5.2.18 reported by safety. These were masked in 'safety scan'
by its default ignore-unpinned-requirements policy, since Django is
specified as a range.

Tested: full test suite passes (view tests on macOS/MariaDB,
tests/test_update.py in the Docker image on Ubuntu Jammy).

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 requirements.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/requirements.txt b/requirements.txt
index e0be38a..4bfcd7f 100644
--- a/requirements.txt
+++ b/requirements.txt
@@ -10,7 +10,7 @@ click-plugins==1.1.1.2
 click-repl==0.3.0
 confusable-homoglyphs==3.3.1
 diff-match-patch==20241021
-Django>=5.2.17,<5.3
+Django>=5.2.18,<5.3
 django-appconf==1.2.0
 django-axes==8.3.1
 django-cors-headers==4.9.0
@@ -22,7 +22,7 @@ django-reversion-compare==0.17.0
 django-simple-captcha==0.7.0
 djangorestframework==3.18.0
 gitdb==4.0.12
-GitPython==3.1.59
+GitPython==3.1.62
 kombu==5.6.2
 mysqlclient==2.2.8
 packaging_legacy==23.0.post0
-- 
2.56.0


