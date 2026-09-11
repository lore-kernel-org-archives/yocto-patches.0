Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5141C88E65
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 20:14:07 +0000 (UTC)
Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48465.1789157646951640754
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 11 Sep 2026 13:14:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=YioFhQzz;
 spf=pass (domain: konsulko.com, ip: 74.125.230.204, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb769ca02so4270781cf.0
        for <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1789157646; x=1789762446; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Mednid1BXYN1aP3O42N9MgApBaXxEXZJJVMxKMxfNjc=;
        b=YioFhQzz8eovKA+OwQYqu1MCph4LJ7QItDNURCRzRF28pkwTz3tlH9d0FAG85hfj2b
         dksgBrtiMOeBiMy2Hscp6D4xSDUCE9IMaOrjTlVq3PnzOrWaCJjqFsHmxsu/qgWRuTBS
         WinageWKi5wMofrFIoUYB3x8gaDb7eRT729zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789157646; x=1789762446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Mednid1BXYN1aP3O42N9MgApBaXxEXZJJVMxKMxfNjc=;
        b=JL444Sh72Ys1BIGFkljcMeUPQ1nVueHlgo0Zmt2aXwVBbZ1Yr+g4ZNFELieqFuvZoC
         +dkqiHVFzXkG+oly7gd5PnniEjNY3WcjvnGaz+p83mBMApdKQKToy3oKJPLwAw/QEMpf
         3ltVrIONPn/eBqALxmkbpkHm/y231kyiQQXBNcxlFkXW8gOYLPU8UQE6kCH4BNG4s+Qi
         Jw2ar/NKb2KW8fIh0qJqc+EvoP4dew+gGS/4AkgYQ7cV4Y5OiFzYWnoEkJWTTco3FWWH
         VSG5DCWk1Ry500/384NG2N7S9o8P7vVvFNoV5CIbdFtm+40102nRsXhu4gBBQLItkq9/
         SyQg==
X-Gm-Message-State: AFuF++kVPBZuzXonMjebxNpEFBmXRI7vJTG1MAEicuIOSB1jQddfwrOY
	Y3USWt3/HHaiwa/qsrBsp3xmwAXczyHpKYvHvUWsuWyDdZz5KfN8TMoOFZq9XV4Sx/YfFev4PRm
	l1aoG
X-Gm-Gg: AYBFou0o7jK6TiWnQi1m9ls4J2sdi8GD1VpWVBEu7eB4KkjkgKhuWmgZzpI+qr/Ivu0
	hG12ATwwTw/k1Z0f5y41bo3rQndUfV4MC+/LzPZWkkyMp0xJu1zPatiAyOL12BaT+87EMdjemkv
	PzZtptbwZBlNCeHZjXI8JAIVxvO1nouQDBWSf2GVxcCcAo5eoumwH3m43/01JbSty5u+RVgvuWC
	RMdigQcJUDbARfvgedLiw9D2VTB424JqENyUJQHXLA4PqmTX5+cEUHyTkMLnChFX17J9Mf3fiPW
	ZC0E8Or8dHJoE71uA0zHlZ5GMzju7eAHMfqFarCk18O9FaD5GU/SoYuofENZtV+GmqXe9Pd3njm
	z+dsHpUaqtyHlANPvpGRrjncZk+Zvjs3Hzm3bQQHHJknX6NWQglg2JlDoT6oNLlh6WxxJKRf01w
	TCrpMVF9FRALu9LqDoPKBfCCD855rAiuO1RocBBN1Y4iBS8eyzoLbmCuddAQELeUUeHXceVith+
	7zUMWiWUkXk84lR27DxEBHZ8IaNcp/M+0B4B6OZXAJdLNeqjBDS4v0YGNGEP+fKGOtvitUrbYbc
	hygzziCfYul76hM6mzs0gchdnuEYm/SlZqlsaikzHHBrjg==
X-Received: by 2002:a05:622a:15d2:b0:530:42e4:1b5d with SMTP id d75a77b69052e-530c8739f51mr105188561cf.42.1789157645686;
        Fri, 11 Sep 2026 13:14:05 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cc781402sm25826061cf.7.2026.09.11.13.14.05
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 13:14:05 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 29/37] classes/ptest-cargo: add explanatory comment
Date: Fri, 11 Sep 2026 16:13:15 -0400
Message-ID: <962f3b6724ea3921418559eeca4acd2dd3b39b4e.1789156653.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789156653.git.scott.murray@konsulko.com>
References: <cover.1789156653.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 11 Sep 2026 20:14:07 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4795

From: Ross Burton <ross.burton@arm.com>

Add a comment to avoid someone else in the future wasting their time by
having the the idea of stripping the cargo hash from the test binary
filenames.

Some packages, notably librsvg, build multiple tests with the same base
name that are differentiated by the hash:

  primitives-3fd9d71b0a55e20a
  reference-00d9b406d910a645
  render_crash-c88a2b880ba97e09
  rsvg_convert-b43bd2236753f43d
  rsvg_convert-eef250e6c0174413
  rsvg_convert-f70976dd6cda88b0
  rsvg-eec8e799568381a3

Signed-off-by: Ross Burton <ross.burton@arm.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit c40a156f543789dc570c5cbbe0ea8c1b48e5af32)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes-recipe/ptest-cargo.bbclass | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/classes-recipe/ptest-cargo.bbclass b/classes-recipe/ptest-cargo.bbclass
index f4c881c..2e008b3 100644
--- a/classes-recipe/ptest-cargo.bbclass
+++ b/classes-recipe/ptest-cargo.bbclass
@@ -95,6 +95,8 @@ python do_install_ptest_cargo() {
 
     test_paths = []
     for test_bin in test_bins:
+        # Note that we can't strip the hash from the filename as some packages
+        # (eg librsvg) have multiple binaries with the same prefix.
         shutil.copy2(test_bin, ptest_dir)
         test_paths.append(os.path.join(ptest_path, os.path.basename(test_bin)))
 
-- 
2.55.0


