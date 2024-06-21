Return-Path: <ecordonnier@snap.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F425C2BBCA
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 12:13:00 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web10.71540.1718971978379416264
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 21 Jun 2024 05:12:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@snap.com header.s=google header.b=ArN6KA96;
 spf=pass (domain: snapchat.com, ip: 209.85.208.172, mailfrom: ecordonnier@snapchat.com)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec1620a956so21817691fa.1
        for <yocto-patches@lists.yoctoproject.org>; Fri, 21 Jun 2024 05:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snap.com; s=google; t=1718971976; x=1719576776; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Vn1bHvEweCIkWbTC2FtYQ3wMmApsIJexRbeHJByMwQ=;
        b=ArN6KA96pi6NWdts5auKoT4hfvg+SsC4DHXPBKzVnlBlB9jfpoy3QMd04HraCEzuec
         2BjMBkENKM7OGXWWovosqZ16A3m2BKOs8JUmg92ZHlUkjmBVRfO66t0rRqvu/ePa6SjI
         MsXpnU5WZNY/moWUzCHODv0KIHxu+C0muBdUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718971976; x=1719576776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Vn1bHvEweCIkWbTC2FtYQ3wMmApsIJexRbeHJByMwQ=;
        b=rj+TbamXxQN7OTmUPr8Lr3A+6fdW/PkYEqPdewQEH3w5YBMaa/VLti8I3/m57IbsVV
         on57RkIP5ldccebfeeYq9jc/h2EWLyqHYcCy4DWiu1htYj/T2jfzzN0US/64/tKyQmw2
         o/IF+LE3T540Jsi8YnjoTqkX2z9bXDtd3y7nzX1kzizrlZjSqa88nbF2CtWtdJglwHVv
         ZygptEOcXMk6D7s3LwW/jmUJre4VumQWogyoTfDBy9uRrq/qBtB8NXjAzpFKssnmBEKG
         bfj3sijlWGMHw4JJ/xkxQkLhm71UoZ+1mlnwIo94hxBxFiQRCvlhPUEVaCh8IbpvVFty
         aPbw==
X-Gm-Message-State: AOJu0YwZfKB8TDaUfDqULIkycn3j/kxavwHI5JIVaLLvmFMts4D/1rur
	xOa83Q37aRPcj/3GDYArn634n3RiXV2ltxvN92qvYUv9ZmIs98YWBM0eByBiySQDZWwh6NHDZaX
	VADg=
X-Google-Smtp-Source: AGHT+IFyLIDTVCwYyNsenevEXQWEkW9asNR53S/NqYVKPbIUuFdagEvHbs5qQ1AASpDTZog8ph4UOw==
X-Received: by 2002:a2e:7d0b:0:b0:2ec:1a8b:c374 with SMTP id 38308e7fff4ca-2ec3cff5446mr46722221fa.45.1718971975521;
        Fri, 21 Jun 2024 05:12:55 -0700 (PDT)
Received: from lj8k2dq3.sc-core.net ([85.237.126.22])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d305616f5sm863931a12.80.2024.06.21.05.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 05:12:55 -0700 (PDT)
From: ecordonnier@snap.com
To: yocto-patches@lists.yoctoproject.org
Cc: Etienne Cordonnier <ecordonnier@snap.com>
Subject: [meta-selinux][PATCH 2/2] README: remove outdated section
Date: Fri, 21 Jun 2024 14:12:39 +0200
Message-Id: <20240621121239.594152-2-ecordonnier@snap.com>
X-Mailer: git-send-email 2.36.1.vfs.0.0
In-Reply-To: <20240621121239.594152-1-ecordonnier@snap.com>
References: <20240621121239.594152-1-ecordonnier@snap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 21 Jun 2024 12:13:00 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/363

From: Etienne Cordonnier <ecordonnier@snap.com>

After commit
https://git.yoctoproject.org/meta-selinux/commit/?id=9e986d7d794f044464e1af914ddbcd57d8f1c2e9 ,
it is not possible any more to choose a different version os the refpolicy, and
only the git version is maintained.

Signed-off-by: Etienne Cordonnier <ecordonnier@snap.com>
---
 README | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/README b/README
index ce91cc1..ae011f3 100644
--- a/README
+++ b/README
@@ -47,22 +47,6 @@ to be tailored for your environment.
 e.g. PREFERRED_PROVIDER_virtual/refpolicy ?= "refpolicy-mls"
 
 
-Using different versions of refpolicy
--------------------------------------
-To prepare selinux enabled images using different ver. of refpolicy,
-we can choose supported releases of refpolicy
-refer to available versions under recipes-security/refpolicy
-
-We can use the refpolicy directly from git repository instead of release tarballs.
-By default refpolicy from git builds head commit of master branch, we can update
-SRCREV for refpolicy and refpolicy-contrib as appropriate at refpolicy_git.inc
-to check refpolicy as per required commits.
-
-* enable the preferred refpolicy-minimum:
-PREFERRED_VERSION_refpolicy-minimum = "2.20151208"
-PREFERRED_VERSION_refpolicy = "2.20151208"
-
-
 Using different init manager
 ----------------------------
 By default selinux enabled images coming up with "sysvinit" as init manager,
-- 
2.36.1.vfs.0.0


