Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9410C87FD1
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 18:40:48 +0000 (UTC)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web11.23031.1753296045081747228
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 11:40:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=cWQfTltl;
 spf=pass (domain: konsulko.com, ip: 209.85.222.176, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7e62a1cbf81so29384485a.0
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 11:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753296044; x=1753900844; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64lIn+jZ72KD2neSCH9xKuvMCFNg06Y6GVYKpgvvpcA=;
        b=cWQfTltlvjLCEzyHB13Xlclyv4CALihEACRdfPJ7V5o8AgxHveCyeyJj/q9PAXOIdw
         NiujfK6CO81Z6Dhsrd0YdY0P9vRfbc9EUJgrsert7oHpwlBdKXVaTopL1K8vIcSPyt96
         YwnZZNBxcECzXbUz6NBr1CvSDYvtsFTyIff9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753296044; x=1753900844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64lIn+jZ72KD2neSCH9xKuvMCFNg06Y6GVYKpgvvpcA=;
        b=sw4YM+lXsNn0dvqOPlA4QGbujaIJ4iMmxALddI8jYlun0utGzaC6PhTEf1rX5cgRrX
         uhXkjDK7sEMeXHLuFB2AFkI8WEOuwnprM0DkEQ0DuNnVBqV9wkNVH0O5dtteFROknClW
         080p5PtXxGvDo6MoUPgnIT4oLnm2WBYRe4DFJoQleHDG5urW+1iGf+m8dd6dhkOaQETJ
         p9rC3VIp/Um6jJ8OgdUoiKwSmIpVQJnJ0XMQygrrKUISCbUHytI+OgHFj/uKegn7AwSh
         0nG9gQ7NnU7QU8FONS726OBJomUs3ST+5MSATQVTlyqFG82JEEwiJUJVZFgv5R1JHTn/
         B2Uw==
X-Gm-Message-State: AOJu0YxZTI0X+mrRIoKfSmsZV6nd4D1+d2UaXmE4UDO3Csd3KHFTki+j
	flPWOiOJ2XdOfXaAwbC78sGZzZdMimLEuGZ3Ypm2RgoAaveZSdVE0QWpiS2iZXXqYuBH9WXIK+d
	DUXMV
X-Gm-Gg: ASbGnctlY4qhV0pB0xS50phanl6ajtvN5NMAna1MZUylrWj92SfjDbNfm8Db0gb0NYz
	nJxneqJg8wtwWKDRkIAU6SHiDMbuBkY85Kz4uVQpA838O/nRK+hOB6reWKaA3vZyIG9R40ejEVU
	fdcaDKlav3jQ3PhHu5BV4IPCOBPmfMdwnEbRi7zt2EiO0iwZSwugVK0tOqsL2maKCpulNh+HxE7
	awM4Jmhl6bNLxjop47K8SxMi+o+JykYkWDX+/8Eb84l2G+LbEuz+3a9l+pYgafmKrQjVUC26VMg
	OeaPYrqXXLz1pbD5uIa3/+WSLshoQuV2NlzKpkj/9pp4IfBzWuTfIDmAza2txZQNqfPvw6wsO2v
	f8B3YpUKQOuvyqwtS+dc6nwkdtewO1WCpBdamt7AGYE+P6ZG+ZTDzRallQpmCkFKAQ6xNrZ+5Pw
	==
X-Google-Smtp-Source: AGHT+IFj7WAAZxBydqH1klYHoYNL9df3BVa6tl4MFUWuvZmT44QSW4cig/+/TJh7agJFzV9sh76c8Q==
X-Received: by 2002:a05:620a:1792:b0:7e3:4416:1032 with SMTP id af79cd13be357-7e62a19b95dmr447221785a.59.1753296043928;
        Wed, 23 Jul 2025 11:40:43 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c77a1bsm697255985a.85.2025.07.23.11.40.43
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 11:40:43 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][scarthgap/rust][PATCH 12/13] rust: override DEBUG_PREFIX_MAP
Date: Wed, 23 Jul 2025 14:40:12 -0400
Message-ID: <76a5ebf4e642726a63c5e9d23938850ab1f53123.1753295655.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753295655.git.scott.murray@konsulko.com>
References: <cover.1753295655.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 18:40:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1839

Add a rust bbappend to override the DEBUG_PREFIX_MAP scarthgap
default of "-fcanon-prefix-map" as it seems to now cause issues
with rust-llvm as of Rust 1.87.  master branch did not see this
as the default value changed to be clang compatible before the
upgrade to Rust 1.86.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 recipes-devtools/rust/rust_%.bbappend | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 recipes-devtools/rust/rust_%.bbappend

diff --git a/recipes-devtools/rust/rust_%.bbappend b/recipes-devtools/rust/rust_%.bbappend
new file mode 100644
index 0000000..47d18f6
--- /dev/null
+++ b/recipes-devtools/rust/rust_%.bbappend
@@ -0,0 +1,10 @@
+# Override scarthgap default of "-fcanon-prefix-map" as it seems to
+# now cause issues with rust-llvm as of Rust 1.87.  master branch
+# did not see this as the default value changed to the below before
+# the upgrade to Rust 1.86.
+DEBUG_PREFIX_MAP = "\
+ -ffile-prefix-map=${S}=${TARGET_DBGSRC_DIR} \
+ -ffile-prefix-map=${B}=${TARGET_DBGSRC_DIR} \
+ -ffile-prefix-map=${STAGING_DIR_HOST}= \
+ -ffile-prefix-map=${STAGING_DIR_NATIVE}= \
+"
-- 
2.50.0


