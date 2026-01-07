Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2330ECFD64C
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 15:00:36 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7743.1767798028464234186
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 07 Jan 2026 07:00:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=hZmxNXPw;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b1e54aefc5so183273285a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 07 Jan 2026 07:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1767798027; x=1768402827; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vx7rsy22l8dLMMMSftoNDtb2O19BkozeoTD7M9PIltI=;
        b=hZmxNXPwIwfSC7+0VzC/ZqD3ydNP6rsMT6bnt+qeiEK4LTmonGN3nGnqs2bdbvMBlu
         1O3WldGaCop7n1uH+PS1q86QVFZHo40h2bSe5MfNlxMUUcjeUSRZEcT9X3GCpEsxpelZ
         9ivZNpefrq9CxrUTyWYBmSVReJgv8k1LJ8bSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798027; x=1768402827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vx7rsy22l8dLMMMSftoNDtb2O19BkozeoTD7M9PIltI=;
        b=QNx13PAO5mIG80x1hqmAEc4IdE06cI75Zy/9LFZJLFPuApr81YJacdg+XxwbflXduT
         J6SQxtGCV5J0nj2pSlAGEVUfEeL3xdxeXsNWY0vj8IN6E89OMZpsmyYF3YxCg22+XrOW
         b9SKClIYRNKPcj+1NVa2U2P9LLyMfTQ256HDUjYJdyqZ8FtVKXkl03IJmXyqb1HxIazm
         Ijv2MKIAEII7wUrBaNcm+hrHMk6Qf0wb6eQ724qJjf6kJjcRqU52eUWI/X+FXKLOWgTh
         vZ2dXurPH53b6b7Up8b3IXnjE5W7eZH4TnjzJgQYfHg4aZ58mWWwGxB77NPcI9aGWHcc
         V/jg==
X-Gm-Message-State: AOJu0Yw8a0xHLyY14IFg2LPv0K/uT6s3qitV9OTr4MFSie3OWUmqTuwm
	RJOTNQ+JAbDlxGHmBX6u6kP7zhQWbDrtveibdp/itMRMIm0czOZxDiXCqLEqh81FKQVghPb0t+H
	3flHx
X-Gm-Gg: AY/fxX6nszjNrtkjX6iAdquipQQRZjd+yuhls4l3y3wnHUcbHVsQ9hiAUzLxGgx8n8+
	9N/Ofs8nNUHENe+EGvRB6PBH1bUefYRKS3JLCPa5Z88TutKWqn06MpoUIvdnRHdIjcJyoxPjgXY
	8TWDwx9JKsyCOvjQ53uChD4a2hH52KLral8tyOEDsZx6QyxyjS8g3Hn9Qzi97vfuJhZE4JtSivX
	+fnT3p5stUJB7wz1QEqZysGfFKoqSg+gmw5xwi/LeRtXunu2TOA89sDMxO967NLRSaH2kYc9CKp
	Q/IQlSpMT5ZITXtFqF4SW5QS3BpUCPBCY0LxTk46D1C/VmsyGz6KbhVh7SoX/7N8/GrxBX+XpCV
	tyPtumbyMm4K8V2M7OuGip5pZmzL3i6CfNQMsCaS+AhRiIVIyGQ0/FxJUbtvkc1XVsj/k5eGOpi
	VJyZpoTWpVCmVaNdmMOnMVzef1ich/ZmundSMh2YoQuDasm0UeGyp5GxCGhscs62BGPi5AI1kX6
	MK/ogxUWE6oTKKWHhkX0FEv+W2Z/3W7C4KBsiEcF3XDQ8jgasn6no/pcMje/uI=
X-Google-Smtp-Source: AGHT+IHxuDKlDUmI9gkBEueh4EvpFboxTltoYpgVhnxozw3MrTbBGOOi/7b2eX7N3mHrIGps5UaInQ==
X-Received: by 2002:a05:622a:1a86:b0:4e6:ebe3:9403 with SMTP id d75a77b69052e-4ffb4a6d332mr35231341cf.41.1767798026479;
        Wed, 07 Jan 2026 07:00:26 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffa8d568cbsm34113551cf.11.2026.01.07.07.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 07:00:26 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org,
	Marta Rybczynska <rybczynska@gmail.com>,
	Anton Antonov <Anton.Antonov@arm.com>
Subject: [meta-security][PATCH 3/4] meta-parsec: Remove meta-clang dependency
Date: Wed,  7 Jan 2026 10:00:08 -0500
Message-ID: <7d0ae0d688d34c1574530cb93c12323ac48f1bb3.1767797568.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767797568.git.scott.murray@konsulko.com>
References: <cover.1767797568.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 07 Jan 2026 15:00:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2909

Since clang is in openembedded-core now, meta-parsec no longer needs
meta-clang.  Also updated maintainers in meta-parsec README.md since
it had previously been missed.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 kas/kas-security-parsec.yml | 4 ----
 meta-parsec/README.md       | 6 ++----
 meta-parsec/conf/layer.conf | 2 +-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/kas/kas-security-parsec.yml b/kas/kas-security-parsec.yml
index 9a009be..c44a280 100644
--- a/kas/kas-security-parsec.yml
+++ b/kas/kas-security-parsec.yml
@@ -8,10 +8,6 @@ repos:
     layers:
       meta-parsec:
 
-  meta-clang:
-    url: https://github.com/kraj/meta-clang.git
-    refspec: master
-
 local_conf_header:
   meta-parsec: |
     IMAGE_INSTALL:append = " parsec-service parsec-tool"
diff --git a/meta-parsec/README.md b/meta-parsec/README.md
index a5472ae..913bba7 100644
--- a/meta-parsec/README.md
+++ b/meta-parsec/README.md
@@ -14,9 +14,6 @@ This layer depends on:
     URI git://git.yoctoproject.org/meta-security
     branch: master
 
-    URI https://github.com/kraj/meta-clang.git
-    branch: master
-
 Adding the meta-parsec layer to your build
 ==========================================
 
@@ -32,7 +29,6 @@ other layers needed. e.g.:
       /path/to/yocto/meta-yocto-bsp \
       /path/to/meta-openembedded/meta-oe \
       /path/to/meta-openembedded/meta-python \
-      /path/to/meta-clang \
       /path/to/meta-security/meta-tpm \
       /path/to/meta-security/meta-parsec \
       "
@@ -257,6 +253,8 @@ $ git config format.subjectPrefix meta-parsec][PATCH
 Now you can just do 'git send-email origin/master' to send all local patches.
 
 Maintainers:    Anton Antonov <Anton.Antonov@arm.com>
+                Scott Murray <scott.murray@konsulko.com>
+                Marta Rybczynska <rybczynska@gmail.com>
 
 
 License
diff --git a/meta-parsec/conf/layer.conf b/meta-parsec/conf/layer.conf
index 29a8f11..39d1265 100644
--- a/meta-parsec/conf/layer.conf
+++ b/meta-parsec/conf/layer.conf
@@ -10,7 +10,7 @@ BBFILE_PRIORITY_parsec-layer = "5"
 
 LAYERSERIES_COMPAT_parsec-layer = "whinlatter walnascar scarthgap"
 
-LAYERDEPENDS_parsec-layer = "core clang-layer"
+LAYERDEPENDS_parsec-layer = "core"
 BBLAYERS_LAYERINDEX_NAME_parsec-layer = "meta-parsec"
 
 addpylib ${LAYERDIR}/lib oeqa
-- 
2.51.0


