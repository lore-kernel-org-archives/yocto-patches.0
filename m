Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC25DC49EA1
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 01:06:40 +0000 (UTC)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
 by mx.groups.io with SMTP id smtpd.web10.46508.1722215198365951379
 for <yocto-patches@lists.yoctoproject.org>;
 Sun, 28 Jul 2024 18:06:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Es1LIMs7;
 spf=pass (domain: gmail.com, ip: 209.85.128.171, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-651da7c1531so15175327b3.0
        for <yocto-patches@lists.yoctoproject.org>; Sun, 28 Jul 2024 18:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722215197; x=1722819997; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XtBtXbhyStijQgHklJK5BesMKz0d1cmksOuFBV8AZg=;
        b=Es1LIMs7PyKZjeGYJ+MJt0MNu8MeKrWNsB04tCGMVAOftZwqE7A+9JQ8acu0b+On2k
         AyT45SWcrMz2b64Z9SJ7wQ4Nbef4ccS7dPAo4r/P8jSj7PMDmxxkGt9HyikOa5yaRkc6
         T0tAiM8F4x9aJ7vIpeWeXMThRjOjmEPolA8cczI7+hkaPZcjrVkG8i8hDv/pxC20Wr9k
         bB/7s8KlmkXjPEJdCoPFkRinOWgdljjV01mncyC13EmbPjzjT4Cg/KQ4QJ1y7dAPQjN5
         pcT6lcl6W82iY7OPirkC7fbiyNHvkwhrd8oJ4db/VbZh8TbLtZ8PZFpgurHzrFpAp7PQ
         NZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722215197; x=1722819997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XtBtXbhyStijQgHklJK5BesMKz0d1cmksOuFBV8AZg=;
        b=rjjc2QO5XiKRnNVzEJ/Hw/VxZZD2f4tjxKHtFc234DzQTO8WLU5GcI2qdzaXCGekEL
         BR4iUeth1GPgXn+m8XYmoNzMuPlE4b2GYParthELwIjjgysXC/f2kWNRuLEdDJEr01SY
         Mro85Hw/vlJUpuAZ5MsPmooCZsjBFTmjuzdizKE99DudYneIJoYzVu8nq1F974Rb7wkR
         9oZUY2ZR+FubvoyBHNMN81idK1c4YFNu84/ZR0mugyRwgJ2Y4vuAYEkJXCRaC8lip9wp
         y9rmbgBrG1FJRNUkbk5clbre+9RnXJ26TZX0Wux85EKv2JgCwcchgZJMAtSNYFOV4QjP
         9Qig==
X-Gm-Message-State: AOJu0YyatgXvC1NIh7P1dtZo/YVMdeGXyywGMb/uELtm3BZXM85kjZ3q
	FIvria2JzIqbxtelChtsM9Y0EWevTrjO/3YPsNZJFGWC8C1EIWpr7TAoWg==
X-Google-Smtp-Source: AGHT+IGOjmsKO0bd4DuOynOdfYR8pT+Kx7BVYJSK5RLoKWS5ZjLJJkPj5rtkd84Rrir6XiX08r53jA==
X-Received: by 2002:a0d:e446:0:b0:654:c11:602f with SMTP id 00721157ae682-67a0a1362d0mr62991567b3.40.1722215197396;
        Sun, 28 Jul 2024 18:06:37 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:47bc:453d:d517:b47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6756bc9edd8sm18543157b3.130.2024.07.28.18.06.37
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 18:06:37 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 5/6] isic: Fix config error
Date: Sun, 28 Jul 2024 21:06:33 -0400
Message-Id: <20240729010634.1991558-5-akuster808@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729010634.1991558-1-akuster808@gmail.com>
References: <20240729010634.1991558-1-akuster808@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 29 Jul 2024 01:06:40 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/485

configure: error: installation or configuration problem: C compiler cannot create executables.
| NOTE: The following config.log files may provide further information.

Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 recipes-security/isic/isic_0.07.bb | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-security/isic/isic_0.07.bb b/recipes-security/isic/isic_0.07.bb
index 3e56091..d39184e 100644
--- a/recipes-security/isic/isic_0.07.bb
+++ b/recipes-security/isic/isic_0.07.bb
@@ -23,6 +23,10 @@ inherit autotools-brokensep
 
 EXTRA_OECONF += "--with-libnet-dir=${STAGING_DIR_HOST}${libdir} "
 
+# many configure tests are failing with gcc-14
+CFLAGS += "-Wno-error=implicit-int -Wno-error=implicit-function-declaration"
+BUILD_CFLAGS += "-Wno-error=implicit-int -Wno-error=implicit-function-declaration"
+
 do_configure () {
     oe_runconf
 }
-- 
2.34.1


