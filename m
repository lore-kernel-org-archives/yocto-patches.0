Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A10DCCFA00
	for <webhook@archiver.kernel.org>; Tue,  4 Nov 2025 10:04:32 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14422.1762250645985495437
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 04 Nov 2025 02:04:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=EhP043ZP;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47758595eecso1635755e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 04 Nov 2025 02:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762250644; x=1762855444; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vPwERKH/tV+LDChdpers1MpjfK7Fgy8TCqMgyJusKHE=;
        b=EhP043ZPHxNEshFbtaOKsZ3pepykC+y8tfmRDmx8ZCTEkR30YPWvntH+uc5wudazQW
         V7F4B2fwAr3Rqz24ZdlfE3cCUoFgapxc8tHlDmUHwHssMPm8f9O6VHPuy7KQhqHs3Fq6
         eYnm015r1xQuQ+JfHeIWxzR+b7Yo6F5Qr0N0r2vGpIPZOCGlQzhsQFYiV7bdIikVj+TP
         lnBMskjxbDDjzqLrYmIF9OlnAydLM2VWsxm7fuNRaPoRXaUMg3ABQzrceU8yUsSbhawD
         gq2TVpb2Q3YL4OOF3kNaVaOs3aDrCu5MRh0AXeADMozm/y2PfwwV8baPP2xLQdd4MKhf
         VH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762250644; x=1762855444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vPwERKH/tV+LDChdpers1MpjfK7Fgy8TCqMgyJusKHE=;
        b=dAIsA/lrj39RAvVoq9R4B9pBB/JWTAr92LETMRAg+nu1TXL/Y3J9CqBs/VYmnhJTQj
         SZrVx1jPOvt7zHuL135GU7jHf46XAw+3V41MOk4iGyvafJitgLGur9dat4IrvCHAmnEn
         FywXi3fn/N4bsP/TsBWxqeiOMy7Mpzgq+hEfzQO3MfcWQqUZ9snDjWT0jEz29oh03cY2
         L+AGepKPmwqtKRdh69YOItxuXh/faLJrLlw7qyh9L9PX4PEV86HRcc0LSlG7jhASkrj/
         1S24j6tjlRyjlnxk3zSTCd1bzpgoVfU4xyoxaFDhA5BbXOfxGoFXBOCYnPS+GgjqOTIl
         2y3A==
X-Gm-Message-State: AOJu0YwoEBi3yQMVAJgWScrMn4RmuYOD68Alt6EGGBXOfJHLYVu7Qxz5
	rG2udv7SwbxjjDYu/DTDmGnOFn2v787W50+1T4nKfxLJaKKBIHgZxaPM98z/tg==
X-Gm-Gg: ASbGncvIYfn2LgTy4KxhefbbB521NSD42nNZu/gys9xiuogEzD/qeiD1kDJd+q1YX7b
	q7tyPQmQ9PckVMw1a3QyazcbbSXBkqBFqu3kcL3Wv9TCxQfzLeAGhc7KBT4X3ufUS92/kTidfoE
	0qN9X2WD2tlps9HANh/ZF4DC55GeMdTeI5S1GdKqpH24a5vw5Og118B1jQLUZ9rvxxti35v5nVt
	g2Ivli7iXE1iS8EGsuRnuqiLLOwWZ8uaLChCpDkc43oOSq5Mb59SAl0JIbMUt6aYcfgUoEXMhRw
	DRR8J52ntgrC0ZvUrmovvxcKMmtd1vpjDeM4YVcNyKyN0yx9FooyWn0d7HH/3dmFWz81Yp5at6a
	5xHn9/wYKLuLC1yVWwW7bbpyiaoLTgc8Ghq/LTlOUqyRQ9S9wU5FXH2sNrDjfE1iBiPcBT2LzAW
	I3x/VZnFYzgAtLYnm0
X-Google-Smtp-Source: AGHT+IGwbcsX4KNY/zd7wyrCpqFhzBJn1khQbCaueLrGVzcAY3gj7WO7WFEZmGHLwfYCpLsJkzo+SQ==
X-Received: by 2002:a05:600d:8314:b0:477:4345:7c5c with SMTP id 5b1f17b1804b1-477434584femr67710585e9.38.1762250643972;
        Tue, 04 Nov 2025 02:04:03 -0800 (PST)
Received: from fedora.fritz.box ([2a02:2455:86ac:8b00:1503:6322:4ca8:d58c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755a550dfsm28340025e9.17.2025.11.04.02.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 02:04:03 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>
Subject: [yocto-autobuilder-helper][PATCH] scripts/shared-repo-unpack: account for --build-dir -> --setup-dir renames in bitbake-setup
Date: Tue,  4 Nov 2025 11:03:59 +0100
Message-ID: <20251104100359.1052750-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 04 Nov 2025 10:04:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2413

Signed-off-by: Alexander Kanavin <alex.kanavin@gmail.com>
---
 scripts/shared-repo-unpack | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/shared-repo-unpack b/scripts/shared-repo-unpack
index 5c30baa..a12fcaa 100755
--- a/scripts/shared-repo-unpack
+++ b/scripts/shared-repo-unpack
@@ -101,7 +101,7 @@ try:
            "--skip-selection", "machine",
            "--skip-selection", "distro",
            "--source-overrides", bbsetup_json,
-           "--build-dir-name", "build",
+           "--setup-dir-name", "build",
            "--non-interactive",
            ] + bbs_config + bbs_fragments
     print("Running command %s" % " ".join(cmd))
-- 
2.51.0


