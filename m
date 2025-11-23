Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4025CCFD31E
	for <webhook@archiver.kernel.org>; Sun, 23 Nov 2025 23:45:33 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5037.1763941527430971423
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 23 Nov 2025 15:45:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=idsg2rWb;
 spf=pass (domain: konsulko.com, ip: 209.85.222.175, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b22624bcdaso481162185a.3
        for <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 15:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763941526; x=1764546326; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPEbQ4jv5f5OfzqavuzEikFXYwyBTK2BGinkDxw8d6A=;
        b=idsg2rWbs3xTpEZeFoHWm4IiaG33T6C78mgJkCjvYHzQXYtrhSgoWwbgnEPpSIOQ6t
         1SKbGwT2CfBsXiLS/lf+71vUNYCqmTUDdGTKJTbkRl8VR2m4QNNR6H7wZeXmceTPw4Pd
         /17vf+Kx4RR4UC4D21V5mlkvhC8vVlfN51T28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763941526; x=1764546326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TPEbQ4jv5f5OfzqavuzEikFXYwyBTK2BGinkDxw8d6A=;
        b=tdATjgEaqjSbbyXrBCci9zYZGfZBT+BpxQ0/Uyfmad5t3vVClrldKM9qrJoRduEwNo
         ORpkKUPcGxYUp2ET4YnRBSWv0OoArfmcNKsBwnERdHBBSMNEemDhZPqLxYWFAVPqfoPf
         M0GoqYIQQ1Wv0VLk6cZjozF3jAO7PFxFKbmzW3H8ThkY9a0eFjBEfgKGh+LSdsQcDLaU
         Wr6HnU9WA5wSwzm8mJLsg8hM+O/XnRUCXQ/CX402x+c3rd5ub7aApZbKLVo2likE7EJg
         k7d8eowRko01chM2eSQ/cn1Y5fU3mljTzl3xeJHQT5xhULXVZfN7Jujth7jUKS7gOIN3
         IE6g==
X-Gm-Message-State: AOJu0Yxz55cME6DOakdvUlF6neT781DoUYJOwsMgHAy8HM5xfEIWokHd
	Sw+m81uWQuitVRnQaLirbXq0yLOR4/nw0zcyK0kMqatZnOhiAeO7sgG3cgnVKR4v7lUWydt4b3S
	FpVwP
X-Gm-Gg: ASbGnct+V/dXGdqkxzQgUSbLhCf67LMye8EpgLvWKu/m48iJdD6EzHpDATNsEry/7mf
	gO7BT/CGc/pILUA/ild58FyJqv47fRKDUm4juV3b6K9u01jtXT3gFO/zOBfzLWGOdNJW80rnyEA
	x5o/zfqG6aX34J9SsBJyEl0MTolkcgau4J5Wmi/5JB9qgdyZOd5aiuve7vuD2BsMzrOu7ChqNpt
	o+ar28Y1h1qqE85jLaD37IVWKXWK6AZOZGhgy9Oh5fPRfRylGa4yjZi0n0jsa6b7p7Mld1OxDmy
	GFJIv8IZWAwsRlpFxsfDBJGf0SNr/a3NrUq0zFs+Fa37ornJKIUbG4ImN/TV2srNvSr7D7CYT+y
	p6aVxrAn0/i7qIzynDmq7g3U1iOab84EH98SxzfZcsNdH6I+oT1BUoIVr/shHY+e+lQ8VEVO4nQ
	fzHinCtZLfvX3OKjUjUgjEHcSYIHl/dxhVtRHkVHgLwhg12V3SfuQN3ZP/R+iJmKg=
X-Google-Smtp-Source: AGHT+IH//XkSnPe4Z+DqOD/JJ9wwibrY0t02Og5W7N2EiwgaYq1yudf3HAgYmJ6tcItKP1HdX3EPEQ==
X-Received: by 2002:a05:620a:3910:b0:8b2:7726:c7bd with SMTP id af79cd13be357-8b33d498e31mr1264039185a.62.1763941526118;
        Sun, 23 Nov 2025 15:45:26 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932db59sm843706585a.1.2025.11.23.15.45.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 15:45:25 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][scarthgap][PATCH 10/32] packagegroup-core-security: add missing packages
Date: Sun, 23 Nov 2025 18:44:50 -0500
Message-ID: <e72b57ca2d9d096295dc7c6519bc4488d3cd2051.1763938436.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1763938436.git.scott.murray@konsulko.com>
References: <cover.1763938436.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 23 Nov 2025 23:45:33 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2668

Changes:
- Add libmhash and libgssglue so they will get tested by CI.
- Switch to MACHINE_ARCH to facilitate the above, but it makes sense
  anyway due to all the machine overrides used in the packagegroup
  definition.  Since this packagegroup is to facilitate testing and
  unlikely to be used by downstreams, it is believed this will have
  minimal impact.

(adapted from 26e745243d6d28768ed4a237d9a48f68210c70a6)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-core/packagegroup/packagegroup-core-security.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-core/packagegroup/packagegroup-core-security.bb b/recipes-core/packagegroup/packagegroup-core-security.bb
index 3ef77e5..10063c3 100644
--- a/recipes-core/packagegroup/packagegroup-core-security.bb
+++ b/recipes-core/packagegroup/packagegroup-core-security.bb
@@ -3,6 +3,8 @@ LICENSE = "MIT"
 LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302 \
                     file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"
 
+PACKAGE_ARCH = "${MACHINE_ARCH}"
+
 inherit packagegroup
 
 PACKAGES = "\
@@ -36,6 +38,8 @@ RDEPENDS:packagegroup-security-utils = "\
     fscryptctl \
     glome \
     keyutils \
+    libgssglue \
+    libmhash \
     nmap \
     pinentry \
     softhsm \
-- 
2.47.3


