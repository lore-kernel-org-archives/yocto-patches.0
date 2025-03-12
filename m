Return-Path: <omri.sarig13@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9BAC28B2E
	for <webhook@archiver.kernel.org>; Wed, 12 Mar 2025 10:33:48 +0000 (UTC)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web10.33629.1741775619692727095
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 12 Mar 2025 03:33:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ckIFA+f0;
 spf=pass (domain: gmail.com, ip: 209.85.208.169, mailfrom: omri.sarig13@gmail.com)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30761be8fa8so72048531fa.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 03:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741775617; x=1742380417; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QC4KiBOiRjsARrYMmoeNsh1SYyyKNTAEJHoulJ9AfbE=;
        b=ckIFA+f0I5QBE3I8E/eEDIhDwwaxnmTWYtEboatl3R+O9bokiRaSZ5JTdNS3A8Y0wv
         VCx4AXsAu4Jbqf2ppJAY9UZgiE6dAqc918n6M6YBFWXe5tHSJ5kVJ4LuH79g7/4lLx5j
         qFd26iZUsKwbVdbaDo7Z+XcHs732VkDkZ94LvGbMOtEooxf3BYRmEuKyzQMvFp4oWZX6
         /n9edTb5YM5hc2mhlz9vpB6xdBZTTZ38o9zaf5krS8OjgLxsEsPg81lW+PVOwoeyoqkq
         PABwJ5k1SRVEMpnhVnIlC6IbuniLLmAHY7ikMtj4YHJKblUZJm66ZyynkmniC80SiyAu
         +Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741775617; x=1742380417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QC4KiBOiRjsARrYMmoeNsh1SYyyKNTAEJHoulJ9AfbE=;
        b=v15o9lxIzFXzzeDYyM9hyw2xnD1kjriU2wRUXzt9h29UcHkPG0wmSGnfhNu1E8MwuJ
         mWcLPFsZxGrh2Fvf3N/yL7e0VcZQ1FM9rPWOSR9Qgs8DIzeDB4RjsFF05HKDkVJhlDVL
         TyMX5pRHG9aSA+Eskx0RiKN2ySiXZI0RJeiHDXZ+Jmo5/PZr1s07SfyI4LQhSbldyYG7
         wpy5NYUhDnD7IrbtjSb7c4RDZsSvK1OAgCB3l9PMYdQnMGI1DHVytUSYBwRgAGNCgoAe
         dYgWpKOsPs7yEZ1/Huirx8USEdppwgXzm2i9ZevNUbB9KylmNJtYf40iXsaEO3cis3ZE
         xR0g==
X-Gm-Message-State: AOJu0YyfHozeqeEOVtia0z4N6Tlo8E+l66d9QJv09Cf73NXKT1hlpjWV
	9MP08X7A9gCKNzJ+CRl/Okw8yuO2iXqwQfiIV0emyHksJf0Z2A+iXl7HeUsf
X-Gm-Gg: ASbGncuRKY8dC76lgMzDIbJWnRa1ybVxSDYCOfURGj5mdcDuoCtBU6SBFfcrQX4jZpA
	C4DMPUEfi9cRJj6RgZ8kEXqPLOf/3oxSFO94VY9osMnt6zhjIX07kkAg2rhw8EbZo41A6pZmpV3
	DYGl7ENxd4ZQeoPHH7bO7CDmcKckOy0qe6LuxoU1l4S4yg8zddyn4qzFkx6VAgd5+T7eaxBRxC4
	HlwlmyfD/qx/EhtQih9SqYnETd94G5mcv+PVsOI/JNsVPAo4jpzJzy6+3aWHhpVcoKrAfg545wI
	iwg2QzsE8hgA0a7IzZcwY+H1KctY6/R3NQwqbmldVG2HpK4EUMetSYfMXlEOIGPVdbf0Zdh7RkT
	Y3lpkYXBDSOh47CB399iZ8wxJlYFvglK4X/UAcw==
X-Google-Smtp-Source: AGHT+IF3gOmVkJ5IHEXE9b7VkYLjg2yJjxPc02cBVgyH0XK7xpFFrRkh8FRW/Kl+sZmQw0vzZJFW3g==
X-Received: by 2002:a2e:bc16:0:b0:30b:ca48:1089 with SMTP id 38308e7fff4ca-30bf44ed6f9mr73783701fa.2.1741775616965;
        Wed, 12 Mar 2025 03:33:36 -0700 (PDT)
Received: from omsa-HP-EliteBook-840-14-inch-G9-Notebook-PC.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30bfceebd49sm18030821fa.60.2025.03.12.03.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 03:33:35 -0700 (PDT)
From: Omri Sarig <omri.sarig13@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Omri Sarig <omri.sarig13@gmail.com>
Subject: [PATCH v2 1/3] tpm2-pytss: Add python3-asn1crypto runtime dependency
Date: Wed, 12 Mar 2025 11:32:39 +0100
Message-ID: <20250312103241.2526274-2-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312103241.2526274-1-omri.sarig13@gmail.com>
References: <20250312103241.2526274-1-omri.sarig13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 12 Mar 2025 10:33:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1191

The tpm2-pytss module is importing the module asn1crypto in tsskey.py,
however, the current bitbake recipe is not including this python package
as runtime dependency. This causes the module invocation to fail at the
moment.

The commit adds this dependency to the bitbake recipe, to make the
recipe self contained.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---
 meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
index 57e284b..4ddf287 100644
--- a/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
+++ b/meta-tpm/recipes-tpm2/tpm2-pytss/python3-tpm2-pytss_2.3.0.bb
@@ -18,4 +18,4 @@ DEPENDS = " \
     tpm2-tss \
 "
 
-RDEPENDS:${PN} = "libtss2"
+RDEPENDS:${PN} = "libtss2 python3-asn1crypto"

