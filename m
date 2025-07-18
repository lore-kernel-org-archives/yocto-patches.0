Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB7EC83F17
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 14:11:13 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web10.21829.1752847871312546092
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 18 Jul 2025 07:11:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=a8yDigk1;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e29d5f7672so189431985a.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 07:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1752847870; x=1753452670; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLJ75hVXgzukzKNS8je7xz7lmIJ3e2Yi7IpfBPcW/5w=;
        b=a8yDigk1/aZcCr8fbxYhP2fulEF6OMeDqjxzR0be3nSj4hoWtQ82xXIU9ZRVYHCOfY
         N86Q4DJ1iea785CwljcvlE8U3UcPkQt+7ITUZhrJ9M8eqXoGBcJ9QIhgZg0GA1PIG2Ob
         jQO75qle8q2TOvYZJfA0dWtw+im8dRc7VD8wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752847870; x=1753452670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLJ75hVXgzukzKNS8je7xz7lmIJ3e2Yi7IpfBPcW/5w=;
        b=B+J3LQ7LiRNkJTHuc9XwEa6T6EVGjM4sJsAd75AUkF2ajcGJxqj0VFsxtW6VlVJwLG
         VtsbBfNLRDErFilIr1ANg69H6kqjQIl0LyRZuYAZywWhab9sXeoMSdeTLQk8WtmwIINo
         98JJv+/oR+7Q1ARv+qRooEc3QSLjpp6JBZF8feT1Wq3iZf7b+t23X1njFXWwHdthd7mJ
         wOE2DwRDD+ew8qFOC4KcQDGVskCtrr+Jxk9mc2KVqp7OlFdvd9c+SFppDsPSHBzBz2fa
         1BXpCXxYn8QYFJZB/H1dNccFWhleBAbefmWXrfSoNFfo33ue3AqmLVjNzKELaD6FMLnH
         R7bg==
X-Gm-Message-State: AOJu0Yx5mFItqtoplbeTaaLBEocYETI92X5dLhWBTWQWEI2N7h9qO4UY
	+MRyWB84n2VOdmPry0/DFdiStBIZrMWOiAUIPozuT0SFpVeBtIkr4DkAonXLxp5/bv7gj0v6GWF
	p6YXD
X-Gm-Gg: ASbGncsaUD1vC5/PiXhurE2wmkbatkbWSuvi8c9PhcXZU1IcifBtyGpBLkoQEySQIxK
	RUMQXWRpu5NcTZvdrLp/ExG4akWR4XyCICM5FtBCbng2Qb6bg0LlNWmHZng4OsT3seNWKwU32Ng
	SdcbZ1j2WI5GhvfVv3XtmCUdNPVf/SLI4eXmeqDLcEX3k5Gzf6q1/j8j7TqfNmefCGWcy/Vom5k
	VweSfUuCv/P5h83sY/XGR+92bfxoXt21boUzayqkAmzeoQm2sUjvLAXDR18OOXk5l7uZvUDwSrO
	e+dWQvYK2YTo/+UiH0MjSh2f7LpZ56meIdECNoivrs/7npCMZzxNWCjQEzvPcM7qYuaAzmBvJuA
	rl1ygoueBedm4ZTFU9WpQLLJGSdLmkJC8wogOpr3OlmXNwp0S/FwPaHKPvqIZG5PYwZ6GQ4qT0g
	==
X-Google-Smtp-Source: AGHT+IHglMvGpCpf8vs2xWQCjy+twjfPWbnb9pKpCgoY5dfKOEZHJVz9o9ttSWS1wfpi9apqZDmjYw==
X-Received: by 2002:a05:620a:472c:b0:7e3:4db4:8ebf with SMTP id af79cd13be357-7e34db49127mr923756685a.52.1752847870092;
        Fri, 18 Jul 2025 07:11:10 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356a0732dsm92368785a.0.2025.07.18.07.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 07:11:09 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: marta.rybczynska@ygreky.com
Subject: [meta-security][PATCH 1/4] scap-security-guide: upgrade 0.1.76 -> 0.1.77
Date: Fri, 18 Jul 2025 10:10:56 -0400
Message-ID: <4b09d567caadeb3c050ce77bdd4dd921719597c1.1752846514.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752846514.git.scott.murray@konsulko.com>
References: <cover.1752846514.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 18 Jul 2025 14:11:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1812

Update to latest version to pick up fixes required for building with
CMake 4.0.

ChangeLog:
https://github.com/ComplianceAsCode/content/releases/tag/v0.1.77

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 ...p-security-guide_0.1.76.bb => scap-security-guide_0.1.77.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-compliance/scap-security-guide/{scap-security-guide_0.1.76.bb => scap-security-guide_0.1.77.bb} (98%)

diff --git a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb
similarity index 98%
rename from recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
rename to recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb
index b9f7a70..a082a70 100644
--- a/recipes-compliance/scap-security-guide/scap-security-guide_0.1.76.bb
+++ b/recipes-compliance/scap-security-guide/scap-security-guide_0.1.77.bb
@@ -6,7 +6,7 @@ HOME_URL = "https://www.open-scap.org/security-policies/scap-security-guide/"
 LIC_FILES_CHKSUM = "file://LICENSE;md5=9bfa86579213cb4c6adaffface6b2820"
 LICENSE = "BSD-3-Clause"
 
-SRCREV = "616d4363527acb61c6494a97f3ceb47ec90f65fd"
+SRCREV = "c1e1ba121d32b3c319b0e25ee2993b62386e5857"
 SRC_URI = "git://github.com/ComplianceAsCode/content.git;nobranch=1;protocol=https \
            file://run_eval.sh \
            file://run-ptest \
-- 
2.50.0


