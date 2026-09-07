Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8B5C79FA1
	for <webhook@archiver.kernel.org>; Mon,  7 Sep 2026 15:28:50 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.37993.1788794930173098171
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 07 Sep 2026 08:28:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=fHp0FsGW;
 spf=pass (domain: gmail.com, ip: 209.85.215.172, mailfrom: raj.khem@gmail.com)
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so3736319a12.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788794929; x=1789399729; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MDZ/jD3vkJ6jWx1qolEQQmF4S67eKyOgbyehH7dV65o=;
        b=fHp0FsGWeUVlwMtf7nZHFh6BbaGSRguc6A7mYpbCMc/M/2Qg1jNLoNNJ0OIGnAo5yX
         bBHL7wYFuxsG/gHLuKbNRvyRH4oQOe6P3RSwMTaK/R4zmURnsbr9QGcmdN939vrMgQ5Q
         UkdrJAdLuAV7OzWJhSp4ihzjbljjXiHVeELVwYY2Be5OySrhq70iCsShFOePj0vJT40W
         k8U38ACPqInQvGZ4MwnFnOIs6OiVBt78cNPGm+L+L8Ds4hVmIYSvtT6Vm/LAt88daGsL
         biN2KiGZS7OkrpHqRdOm84ojqUgvdXvfKqMbbhFFuPMLq54sQwO7Edcdjg19nAbsr/cs
         lkvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794929; x=1789399729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MDZ/jD3vkJ6jWx1qolEQQmF4S67eKyOgbyehH7dV65o=;
        b=jR+oeQrYezICF6bT27wMnLZYFhFN3+lG+ue3MiYHEkn2RZishlMKNlOJEb4q6tJCvx
         dNwPGaVG16pCLlqA8CNU6yW4hVRv5l2nN1bFBehMbBOXINHXanGijU+n+wi8nyw1OE3r
         zH+FsZ8n3l5ZzAmXP20Oxgvk9cZTl0l8YPr7zjYm+VgnGLatYdDhObsCHe4dU8tk6K6k
         hx9QRCHtxXMo8TReG/cmzk1KfK+1DlNbN3gucHeFFVNtSuG3fElEkz7rk5a8CV8obvEt
         OuGaPMiCoevmI3q+0jB0j6OjywhqY00LkeNOZqgbviPvgri/NArCX5klrNby7iqgS/w7
         oEDw==
X-Gm-Message-State: AFuF++kDHCS2XNxA450t9qc7RC41jJUMeblXvy3TVPhI42UOBiEbFzLK
	04CajNV0KKUAc2NaGK3B/e1jW+RdEk+LjFCYKjxxrdTMZloyja1RY5i2lPhxhQ==
X-Gm-Gg: AYBFou14oNp/8hhHkR7a2qjftNNHRr7kJIdOO/FVCBA2SbhkqBoY97p4rsWHqJB8Eq4
	hUk8HvpaqmFsHByZwrzuIcYli2xuILmpFGRBJ9qH6K9/9TEyPaYAy46DPlUUvZ0zMvBJY0s7g1R
	GwYYPXDPLnmYLiYv3mEetwzF4gGR9Eg00CEIt60pCtsCLQLb+PIrsJACqcx1MvgQIxB4XbWwNLk
	ZQ2yI7RyYFafjFpsOBdpIku/GuGApk1kwRuX5pCIdZFAUjyDz9vC26aBCb6ZBImi3vaW2PatQ7g
	OsSOV7+K+CcqUtylR9J7QogSY7auoOK+/0Yz+gjbjhbcxC9AFF0tN5VnU7QvQr4wi0EAzQlDfbq
	k7bYavBRQEmkeAKDVuZHpG/LVuhldIwMIpaqTKa7WsW5nB3Z7n7+ojZ/6K7eQLvoXUTkPw0jNDt
	fbD/Gz0DgVAHUkzyuT/8f/xrP1dutpb48yd/1/Eh5pI+pwSdLuMgtv/5oMNPltXhqMgSG7qpibQ
	iJFlpQWmlzsW9ZObizZKkmmPjaYBxvKTyoOIsIdK2MP6GN4vUlzllZ5wFptP35TkO3io7x1MfKT
	mZXF7NkB0ciH7dMjdkavdGi9g4sTkdSXltTwggEg27MREweMGOoAKpChKA5ZKC0I+2adnx7+zGZ
	x0ISFXASa3yuSw4VLnnka6CgObUGi7wNMDADUDGSp2zq5FQ==
X-Received: by 2002:a05:6a20:2448:b0:3d0:8abe:9e08 with SMTP id adf61e73a8af0-3da39b57e49mr34762971637.3.1788794929422;
        Mon, 07 Sep 2026 08:28:49 -0700 (PDT)
Received: from apollo.localdomain ([208.95.233.74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa37dbdsm24772767eec.11.2026.09.07.08.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:28:47 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
X-Google-Original-From: Khem Raj <khem.raj@oss.qualcomm.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <khem.raj@oss.qualcomm.com>
Subject: [meta-security][PATCH] packagegroup-security-tpm2: Remove tpm2-tss-engine  from packagegroup
Date: Mon,  7 Sep 2026 08:28:44 -0700
Message-ID: <20260907152844.2763015-1-khem.raj@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 07 Sep 2026 15:28:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4750

engines are not available in openSSL 4.x

Signed-off-by: Khem Raj <khem.raj@oss.qualcomm.com>
---
 .../recipes-core/packagegroup/packagegroup-security-tpm2.bb     | 2 --
 1 file changed, 2 deletions(-)

diff --git a/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm2.bb b/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm2.bb
index b04851f..423a86f 100644
--- a/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm2.bb
+++ b/meta-tpm/recipes-core/packagegroup/packagegroup-security-tpm2.bb
@@ -22,7 +22,5 @@ RDEPENDS:packagegroup-security-tpm2 = " \
     tpm2-abrmd \
     tpm2-pkcs11 \
     tpm2-openssl \
-    tpm2-tss-engine \
-    tpm2-tss-engine-engines \
     python3-tpm2-pytss \
     "

