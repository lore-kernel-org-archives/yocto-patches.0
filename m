Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB5AC6FD3F
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:09:55 +0000 (UTC)
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
 by mx.groups.io with SMTP id smtpd.web11.5843.1724875794776811931
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:09:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=ZexVOOoI;
 spf=pass (domain: konsulko.com, ip: 209.85.166.44, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-81f96ea9ff7so355572539f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875794; x=1725480594; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75U84QlaStjWwWKjMFnsYRCC33/Zheto0akvKSOon64=;
        b=ZexVOOoI05VaTiZ+KsPaGKk8Hay8L/YbLCqOclUwhAIOQllPjtX4kn+NJ8cIfvIjUK
         khgCI7B7V7dipJuaZOY9dpsvF/PvGgEjvJ9Eb/eVyZ7lMpXH+r0RTPYlymRbfLv9887h
         qQuuHDNuYf8tvo+pO3so+rz3iAg9r1W0Lvmfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875794; x=1725480594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=75U84QlaStjWwWKjMFnsYRCC33/Zheto0akvKSOon64=;
        b=n/TqeGDfXBdKxQwWs9OVXDtH3KkTlLgiqNRXtERJ0EvHPZsmIkTQMQp1tnfli02l9M
         kP9Nqwo9l0ngFeoCeGXGiJi7UcdOVxuAndcwv+RYhepiiqs4LKP7M7oRAmTVIT0yA8n2
         RDuIa5VdFo1Uq3JMn4OTlWqTJ4wFgmagXAeLphe5K0GxCAsrSmQLmDyK3GXPF1ZTn9At
         PUSxj81O+6clFufgVM7A+vpkVG4IduOlUK5KnBE78rJ5vvm6VhYSiO0jK2iIXIZdcmx9
         mxP1/eEhk/39Fo4u0qsc0zuWjfAqvN5XllOquvGUMcfe3/Ma6CKCphX6a19jXhI+DD8l
         sL8Q==
X-Gm-Message-State: AOJu0Yz4R76MNxfD5xNb5c6jQXY+LJgDK9ApeXAQBYmnzM5o3CRTQAMP
	Sl707gSV24NmyqxRK2v4jhrVZmHo0hTWbJigJOv6xFkxOVgnRa/K3s96HFBFMXL962UQthVlgej
	3
X-Google-Smtp-Source: AGHT+IEm70Q8BA8Ydp3tEQAvImWYaswOyHvDTV0MArRh3fX4fnf+Rvra9g4F+mmsv4AowYP6vKK1rQ==
X-Received: by 2002:a05:6602:2c13:b0:81f:b38c:3537 with SMTP id ca18e2360f4ac-82a1104fb16mr97511639f.10.1724875793767;
        Wed, 28 Aug 2024 13:09:53 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.09.53
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:09:53 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 07/33] rust: set CVE_STATUS for CVE-2024-24576
Date: Wed, 28 Aug 2024 16:08:53 -0400
Message-ID: <8e967c2b55896dc850eb77473a34b72ff86fcb77.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:09:55 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/573

From: Harish Sadineni <Harish.Sadineni@windriver.com>

CVE-2024-24576 only applies when invoking batch files (with the `bat` and `cmd` extensions) on Windows & No other platform or use is affected.
More details about CVE is here: https://nvd.nist.gov/vuln/detail/CVE-2024-24576

Signed-off-by: Harish Sadineni <Harish.Sadineni@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 28eddfa53494c7560861feff84be3f3a5a46aecb)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust-source.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-devtools/rust/rust-source.inc b/recipes-devtools/rust/rust-source.inc
index 6bef990..b14221b 100644
--- a/recipes-devtools/rust/rust-source.inc
+++ b/recipes-devtools/rust/rust-source.inc
@@ -20,3 +20,5 @@ RUSTSRC = "${WORKDIR}/rustc-${RUST_VERSION}-src"
 
 UPSTREAM_CHECK_URI = "https://forge.rust-lang.org/infra/other-installation-methods.html"
 UPSTREAM_CHECK_REGEX = "rustc-(?P<pver>\d+(\.\d+)+)-src"
+
+CVE_STATUS[CVE-2024-24576] = "not-applicable-platform: Issue only applies on Windows"
-- 
2.46.0


