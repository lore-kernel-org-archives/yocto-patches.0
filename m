Return-Path: <sebastian.trahm@googlemail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD54FCA187
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 20:24:50 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24375.1773087886902948989
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 09 Mar 2026 13:24:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@googlemail.com header.s=20230601 header.b=To8IWYGi;
 spf=pass (domain: googlemail.com, ip: 209.85.128.43, mailfrom: sebastian.trahm@googlemail.com)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48539cbb7b1so11117195e9.3
        for <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1773087885; x=1773692685; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ykx0Cp4sVchh2yjqgVIkLtyPhS7RUSJvcLxHeaGLpMs=;
        b=To8IWYGiFth79/cswTLyzWmRMzgvfNwAkETFqTIgpAGK/LwlIl7jBdmXX7nuCTK1gi
         AHE1ydyjg9UnDw9GGp9VQPjcXUmbVRweIAodgKdfMCtF1d59SRzI2bgiObDluUBHaxmi
         v4WwaHmvLN0dV4eFkQQTv3iPzQegGnOJ0mGXmNkcBM3IrGODdHsk0FusZVQmY3c2cSXI
         JE8PdWh0b1UkZwgOCq50taOBOvq66/yYZMTM1k58vEwzztWdUDxi2lEAQfFe7/gfJX/T
         clc4wyd1nmQKXxYaJRkePVRuG+brouqIHQ2M4rXTUmHkv2kNHolWBOCtj59Tc49NiUoB
         BdPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773087885; x=1773692685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykx0Cp4sVchh2yjqgVIkLtyPhS7RUSJvcLxHeaGLpMs=;
        b=E288k9m3pDKJcA5bbo365xwmgiGbWNU51sMpxFyYeb9E9pHbEPCNvnF4z0pB83Z+GS
         vKVSOmUKmJyK8EYNcZWPboxHQ59OsIqxDOtgW1Ajj7+IY2dpCG30UNBVomacORo+ZKpV
         KlbjhI4RggJrf4WbwosjE9MIsAF7Y6+ZFWVv4jERJBoWlSYTVyFeYEugn4oQicyQ/qa7
         XY7g+YPB2H8qp9R9TYWi9P5f8sdH5AJXgOJz1/sWuqXxbcJyN8v4d2W4HmPNIU9f6qPK
         a48aCc7vgMLNcWamKv2dEFNh7WC+Xg8diGMiRTNA5f7hkr2bmU75hBQP/omkjOZ9Heos
         YlSA==
X-Gm-Message-State: AOJu0YzV3cRbnMpcIiZHmvRJVk4COUrbSU7CHroP2Z62r73jBH/BlCBH
	AKQJe7WmjS5LiEOwI1oPCELSeLlcNdg8BwpqCmQRtDhgEXsLsEeyQpkCsDjT+NKq
X-Gm-Gg: ATEYQzwXDLMdBP92EVMiTV1C43dFGMAaBJvYNhFJpbjgVQrEpJAv5N6RtpdA8uB5pYA
	5SN4qWr3JBmvsSmk2FHl240VZogsMbqfoNuJWOSqkpIK7fO5eRHsaJIcCQUcL4YqknVTGOhfLWi
	Iwkbe7xDbd8d7I7PdUN661QZcZI/2a7EyL+KdAtjZnDIEz6N+r4LyqqC/gWvRg9bpI+wJZwonCY
	kwokDNsBKblZFMDvbwh1DrmPsF5rsxKsk3Lw+/Plez2Kn3nPapVrYontr1ZvUfLh5QZKVW5nu9U
	Sm+daUCMLV4pgn7Sjatuy6R6GOBaUOD5dg94S70AZ0mtuBoxIQfOr9MwVLPzQ6c9xBaoG2Go/Px
	UCDssldXq2Br8SJXs1mIw+bqJo5gliIK3nyFJ5jEA2rTsHR8kB4Cy0xD4trsqIBlKYXzxKC/CLQ
	WptPcCHKCofEbPL091PS5/7A/8yyabdnfyZ/1MD6L0DqQ=
X-Received: by 2002:a05:600c:c0d2:20b0:485:2a4b:7bc3 with SMTP id 5b1f17b1804b1-4852a4b7e63mr137120735e9.4.1773087885018;
        Mon, 09 Mar 2026 13:24:45 -0700 (PDT)
Received: from aerie.fritz.box ([2a05:fa40:39e:3200:afca:d5ad:bc4e:39c0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541a8d4desm15126145e9.8.2026.03.09.13.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 13:24:44 -0700 (PDT)
From: Sebastian Trahm <sebastian.trahm@googlemail.com>
X-Google-Original-From: Sebastian Trahm <sebastian.trahm+oss@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: alex@linutronix.de,
	Sebastian Trahm <sebastian.trahm+oss@gmail.com>
Subject: [yocto-patches] [meta-lts-mixins][scarthgap/rust][PATCH 1/1] librsvg
Date: Mon,  9 Mar 2026 21:24:40 +0100
Message-ID: <20260309202441.295553-1-sebastian.trahm+oss@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 09 Mar 2026 20:24:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3386

Add LDFLAGS in order to address linking issue when building nativesdk-librsvg

Sebastian Trahm (1):
  Unbreak build of nativesdk-librsvg

 recipes-gnome/librsvg/librsvg_2.61.3.bb | 1 +
 1 file changed, 1 insertion(+)

-- 
2.53.0


