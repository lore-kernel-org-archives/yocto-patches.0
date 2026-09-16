Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04919C982CD
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:42 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27121.1789597839633946955
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=dBNPL8Z6;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910ca5aa7so17971985a.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597838; x=1790202638; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=pn1ziw/2Ct0AV93+LleKcaEf4OfiR5j3sKq4oZLw3Ag=;
        b=dBNPL8Z6AfOhJiSrwJqn8DTQYa02FIbOFtUDtLh6ZbIbgXT4pLPxgnGUwjMe2Qf/Ex
         zmSGCz43nl2qXPBVAAILLUM/oLCQTPUfJ2t66bB6bsF8wLdz1LlSX3pMXhcL8dmISHiS
         z9PB3y+wuCdAWJesjyNdfTAtFXoMsgVOYlLYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597838; x=1790202638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=pn1ziw/2Ct0AV93+LleKcaEf4OfiR5j3sKq4oZLw3Ag=;
        b=uyhvuP2hj8tHWmAWliZwAMPfFHF7DCIED/uMTnV0/y4Ch8PclymTFfkPFIRY2hYJIp
         sgRW73jc91g5PQieQRL/xIOUEjSWuvki+T1YwAZjxRWrkdLPLjjIB9T+DQLayQ8XTnkq
         IRChEwu7YMbsIZV3IXsUlwK0ITwDMYPXRV/sk0+HZ0lEZ3gy3RYNYR/9s4vN8EmDG//M
         PMXJMRXqPDaDjMcxicGUKRb4PznnAQqGDWuSgJG54ruTl5CuRFV8wttUHfQK6c96z8LJ
         Tgh+WHQpaK+yFqj5d1LEXJl9e4p7mbSnWDSSmOavYVuiDncg5QgqkgaVo9xBknrswam7
         eYHQ==
X-Gm-Message-State: AFuF++kefldSMhdbLEWTEMrTo+5dUfpAs2mhs4EOXyAmxVuNJonOdbsl
	zQqtAdF1Q025YCK6HsJGsv5XGG/mmjyx+vlczVWFL5IE+0IFsoTajEJ8bUWlrN4gyuLTUlt+MYs
	y6NrT
X-Gm-Gg: AYBFou1jrElCnOHexwlS54fGy5XxgVTonEl4BXIwMQkeOip8rD6SezbMGSHZtL9nOcB
	K4/R9hg8NP6+yKv7KhmrRpM+rhKdvgrs1noeb1Ww3AyjKWNXU2fMWWfgMVA0uzvWJUc6iA3CAcM
	ixgNKwJse/7EthBMRVsdhazEckGSevK6Wim2AWMhteAerNZzMRW/uNS9+OlrZnXF8gRjjqpjZxd
	TcjhhO5K+ywgsvzo359eY5dW+fvmQjmoeohn0LpiHF1boZ5TMj2hGgodUm62BzmuPueqCUrgm3S
	h0sIQmRg6NPLpwo3fw2WP8Hcsldi2cckyujuESrFVSK1I3o7H2fZyNoKzYkAtQXeYo7+J9r/b6D
	iN5DtohP2OpJrcTineTdT24Yal7rSmhQn6SHBhl5kIejz3mPzn9lRaAGkmiJYGkYqNcjM3BD/d1
	EUpWK+YRIz6We2NP/KSqv7MuZfGA5enlJ4jiCQLNp2DfWTw7DQWE5MwQ3wPqhDZrfenlf0vCflJ
	K1Vnj+WP9yxvMGDCq3hfF91zAi/yKqEKeAAxBaXj382GglFdw3uwdNRayzlPBRkMS6EXPVVjqeH
	EKU4fgyudAFFa70hfU/pquNAjUZPQz9lERGT
X-Received: by 2002:a05:620a:2948:b0:930:987d:9cd7 with SMTP id af79cd13be357-93bb76a9f36mr780908585a.11.1789597838495;
        Wed, 16 Sep 2026 15:30:38 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:37 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 08/24] tpm2-tss: set status for CVE-2024-29040
Date: Wed, 16 Sep 2026 18:30:02 -0400
Message-ID: <452d3452a7c0bf848613d271c7f908f618a12db2.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4884

From: Peter Marko <peter.marko@siemens.com>

CVE-2024-29040 is per Debian report [2] fixed in 4.1.0.

[1] https://security-tracker.debian.org/tracker/CVE-2024-29040

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
index f8e87a5..30e984e 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tss/tpm2-tss_4.1.3.bb
@@ -94,3 +94,5 @@ FILES:${PN} = "\
     ${sysconfdir}/sysusers.d"
 
 BBCLASSEXTEND = "native nativesdk"
+
+CVE_STATUS[CVE-2024-29040] = "fixed-version: Fixed since version 4.1.0"
-- 
2.55.0


