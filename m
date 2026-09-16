Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BF8C982D5
	for <webhook@archiver.kernel.org>; Wed, 16 Sep 2026 22:30:42 +0000 (UTC)
Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.27120.1789597838707889871
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 16 Sep 2026 15:30:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=iqLHDz79;
 spf=pass (domain: konsulko.com, ip: 74.125.230.235, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910ad20d4so16118785a.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 15:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789597838; x=1790202638; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=d2K+A9aMaJzVR8BxiZn+zkAAp7c2uRwXNlQwTYVyD84=;
        b=iqLHDz79hizIPD4SsWXHkR1yqIbr1I8aDKuC+wXjLjxUL9OT7f/Ywc0JTc8fo88oHV
         HPDtGE6nKc9CcOoaM3gObDH7cob59NOdzMMU5DAKJL8p/ZhQTtFwf+Mv90nD7SSJmlPi
         7bmAzpXeWyLiwOvPD+D8GZn1S/Cb7Gdvpo3oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789597838; x=1790202638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=d2K+A9aMaJzVR8BxiZn+zkAAp7c2uRwXNlQwTYVyD84=;
        b=N4GCCVNN1bVM586+CWk42bLmCPFDZVuynjzLubeYXLUehYXJv1MubZvOOb069Thz0z
         Wh/MihHRaOq0fFfhAOyab7D/XNUqd4JJymfAHNxu0361Tp8hMfpAPVvPPBZ/9+3XKCeE
         sMI9AGYhFag1ejhgaCmlox2l3fPCggrvPQWOZeSS/ShllKltpmRcrFtnAtM4E4TZWhjd
         68W8E4UxbtnQy4FudXyys4bTnQ++Uv0AQp1nxkJ5H+k/KSX/gEB4xAKlFA9FWfRkazQz
         UzHNyA8Y2+a8fcWJNK708ZmgylhrQsgrq9C62bOTpogdP3yFHKWj47WBItAEbmf7oFAq
         Q2Nw==
X-Gm-Message-State: AFuF++msKBbb7QWage5lFpGT5734pz9A1zIK6v6leE0BMxQ5jRSj9g64
	GQAtaRO7W+273pGf+igw8oRyQc2unUQzXjoglnDWj2V7A+xGQQL3dM6OfGo4MgfU8SsuHhGexa4
	w8f0W
X-Gm-Gg: AYBFou3DNTSqNJvXA4fQw2yZ8+dC7NTedt9b/phU7aGM2aPpfDPKWYiz9xUQp+7wevZ
	0noOm40WEBgmv0ZkBFCRWxyfDLnyx87DaK+/isWfB25Vxf2yZODVBqtOvkzQu+4W7xuXbVkzjUK
	aTEPr9ZCd6pcZZGJqz1T3aGjaj4jV/4rbbJUaLjgEqyyRpD3L9IwLW+jEnVhRzn82+DjGiiN69O
	VBjB1dXOrVnWCJIjBaUW/fV6MWGaV64GgkOT5IgYioSf/L8AUQZbXMPqS8sLQ6R//aqZzlk8wO7
	WGimMyx+VkX9lC8JQMQXwyEV30vkKdU758MfyGswO03wKhNHLNmHPBfXuTVxMncZJh2c4EKD6OR
	HcOqTBuCOQAe2lj3Q7K0tYiWQZ8GWBkaxoGaSaHJZJVnC1dxZ/sxz3hYnmnE5EW3LCqFuq46F0/
	02VYwtyxZn440oGWxl7RckfpE45scMAX7klE9XvdcXum3ih8IEC2ASGCqsLoA+ZV7bmozERpF4h
	N4dmUb4xeJ38lb5juhb25dZQ6Hq0Ll8K0fYmTqDf3p7CIy+FVzrcu2RfVgrz6IJyqhMSJOve5xN
	GmRSI/MD+XubSKP+Jk7nbnAr4gCA2o6Oyow=
X-Received: by 2002:a05:620a:3910:b0:939:3a81:326 with SMTP id af79cd13be357-93bb78ec108mr780139285a.37.1789597837414;
        Wed, 16 Sep 2026 15:30:37 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b781d94c0sm310900685a.10.2026.09.16.15.30.36
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 15:30:36 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][wrynose][PATCH 07/24] tpm2-tools: set status for CVE-2017-7524 and CVE-2024-29039
Date: Wed, 16 Sep 2026 18:30:01 -0400
Message-ID: <0a641b1ee836d4892751987ed9d6dc6ac03ee03e.1789597604.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789597604.git.scott.murray@konsulko.com>
References: <cover.1789597604.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 16 Sep 2026 22:30:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4883

From: Peter Marko <peter.marko@siemens.com>

CVE-2017-7524 is a historical CVE and new cve-check does not undestand
fixed version data. Debian report [1] shows fix commit which can be
linked to release information.

CVE-2024-29039 is per Debian report [2] fixed in 5.7.

[1] https://security-tracker.debian.org/tracker/CVE-2017-7524
[2] https://security-tracker.debian.org/tracker/CVE-2024-29039

Signed-off-by: Peter Marko <peter.marko@siemens.com>
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
index 04ada78..5c968dd 100644
--- a/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-tools/tpm2-tools_5.7.bb
@@ -19,3 +19,6 @@ PACKAGECONGIG ??= "efivar"
 PACKAGECONFIG[efivar] = "--with-efivar,--without-efivar,efivar"
 
 BBCLASSEXTEND = "native nativesdk"
+
+CVE_STATUS[CVE-2017-7524] = "fixed-version: Fixed since version 3.0.0"
+CVE_STATUS[CVE-2024-29039] = "fixed-version: Fixed since version 5.7"
-- 
2.55.0


