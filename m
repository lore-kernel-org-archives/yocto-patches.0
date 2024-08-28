Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909E3C7112E
	for <webhook@archiver.kernel.org>; Wed, 28 Aug 2024 20:10:26 +0000 (UTC)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
 by mx.groups.io with SMTP id smtpd.web11.5867.1724875819292212258
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 28 Aug 2024 13:10:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=W4CuUqt5;
 spf=pass (domain: konsulko.com, ip: 209.85.166.53, mailfrom: scott.murray@konsulko.com)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-81f96ea9ff7so355592439f.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 13:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1724875818; x=1725480618; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qplhQZvhZqqEO9AH/2vR6Ctmz+chmg/ZztA+eYOfSb4=;
        b=W4CuUqt58vxRtBp399k/h1W8W7EOI2URZpKS5totD/VhXfPRXWsn+8fOkjMaARYzzh
         5gdBk8uD6XhRJIhTsLqW/2AaWX5dgn0mg8y3eeBNBgJUOqT6eV7nAYkLteb/svh+pi9S
         sSMiZFNLb8YiEawqvl95MPwzy4wyFcNWapCig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724875818; x=1725480618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qplhQZvhZqqEO9AH/2vR6Ctmz+chmg/ZztA+eYOfSb4=;
        b=duqUFiOBR9TXL1HjeEQIdQL62S3gYxoAYvmYnM9oLV81Cno+kb2qObJWcqn8tQTVcb
         9izz5xSk2SmsHz2vXK3AdiMEfrHq4FPNYlYsCchYqfTL/uIpGCWYnYk+/7kFagXjG+E6
         lRavIoXmpAL7NJmPA9TK66UlqKBMNSInbIikLYUKCjzuNSR9+goPa6v92O5/cWY2tgbw
         /TAhS++GaRJLMbrunaFggmWmGqvsQ+BnwujzNvFodpXO/X7n179Mc1+Srmp0qef51KLq
         OXPckvzzcQ/hABMGyRzuAageVz3fpegnMz+HBbZ+JiLe5SDjD3/tLNhJQgHlQLzaUD8k
         7Gfw==
X-Gm-Message-State: AOJu0YxrRXo/iaL5JQTqNpzEBjbdvwDyzL8svyAh5E0CR56Rn8+Dx7Ir
	uR7KIjmXvf0v3bCyubuGQdXH/dNAFwp07e5bFoDMuAO0KWp7H/UNg0/vLgJUW5o7my4qlFvOKwL
	t
X-Google-Smtp-Source: AGHT+IHEt+0jOCdstvzrwI1DCjXy3w0tqjKuCp0Daw/tuw8c/nCsp6nZ87ktcZBJaF7wfn/TJ4ykXw==
X-Received: by 2002:a05:6602:29c6:b0:7f9:1b3b:8465 with SMTP id ca18e2360f4ac-82a1108c99dmr95264339f.11.1724875818186;
        Wed, 28 Aug 2024 13:10:18 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced0da0e2csm25431173.109.2024.08.28.13.10.17
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 13:10:17 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 33/33] Rework and update README
Date: Wed, 28 Aug 2024 16:09:19 -0400
Message-ID: <6a13fff3bd2945dee63e9515db11ef69cbe9daec.1724874972.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724874972.git.scott.murray@konsulko.com>
References: <cover.1724874972.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 28 Aug 2024 20:10:26 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/599

Convert README to markdown and rename to README.md.  Update its
content to include:
- clarification with respect to testing done (i.e. not done) for
  all interim Rust version updates
- dependencies section
- contribution section with pointer to yocto-patches mailing list
- note on patch policy to clarify that changes other than backports
  or demonstrated build fixes are unlikely to be accepted
- comments about cairo backport addition
- current policy with respect to handling UNPACKDIR changes

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 README    | 40 -------------------------
 README.md | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 40 deletions(-)
 delete mode 100644 README
 create mode 100644 README.md

diff --git a/README b/README
deleted file mode 100644
index c79d73e..0000000
--- a/README
+++ /dev/null
@@ -1,40 +0,0 @@
-"Mixin" layer for adding current Rust toolchain into the Yocto Project LTS.
-
-At the time Kirkstone was released in May 2022 it included Rust 1.59.0,
-and officially Kirkstone supports only that. This thin special-purpose
-mixin layer is meant to provide a current Rust toolchain for Kirkstone
-by backporting the appropriate recipes from the master branch of
-openembedded-core.
-
-Notes:
-- cargo-update-recipe-crates.bbclass has been backported with a tweak to
-  use host rather than native Python since kirkstone does not have a new
-  enough Python (3.11 is required).  Using the update task in the class
-  will fail unless the host environment contains Python 3.11 or newer.
-- The newer version of librsvg from master has been backported since
-  there is not a straightforward way to update the existing one via
-  bbappend.  Backporting a working recipe should be easier to maintain
-  than developing an update of the older recipe in kirkstone.
-- python3-cryptography has been left alone since the recipe in kirkstone
-  still works with the newer toolchain, and updating it seems to have
-  more potential impact due to upstream API changes and its known to be
-  finicky build.  This may change if sufficient rationale for doing the
-  backport becomes apparent.
-- While changes to Rust recipe and class files related to oe-selftest
-  support are included by necessity, no effort has been made to backport
-  the actual addition of Rust to oe-selftest, as that is considered too
-  invasive and maintenance heavy.
-- To include Rust support in a SDK, do the following in e.g. local.conf:
-
-  TOOLCHAIN_HOST_TASK:append = " packagegroup-rust-cross-canadian-${MACHINE}"
-  TOOLCHAIN_TARGET_TASK:append = " ${@multilib_pkg_extend(d, 'libstd-rs')}"
-
-  Overriding populate_sdk_base.bbclass to avoid needing to do this seems
-  too invasive for this layer.
-- The intent is to track any further upgrades that occur in the master
-  branch of oe-core, with an expected end of support in April 2026, the
-  same as Yocto Project's planned EOL for Kirkstone (per
-  https://wiki.yoctoproject.org/wiki/Releases).
-
-Maintainers:
-Scott Murray <scott.murray@konsulko.com>
diff --git a/README.md b/README.md
new file mode 100644
index 0000000..047d647
--- /dev/null
+++ b/README.md
@@ -0,0 +1,88 @@
+meta-mixins-lts - kirkstone/rust
+================================
+
+A "mixin" layer for adding current Rust toolchain into the Yocto Project LTS.
+At the time Kirkstone was released in May 2022 it included Rust 1.59.0, and
+officially Kirkstone supports only that. This thin special-purpose mixin
+layer is meant to provide a current Rust toolchain for Kirkstone by
+backporting the appropriate recipes from the master branch of
+openembedded-core.
+
+Notes
+-----
+
+- **Not all Rust version updates carried here have been individually tested!**
+  Care has been taken to keep backported changes in the same order as they
+  have been applied to oe-core, so the various older Rust versions should
+  be buildable, but that is not guaranteed.  It is highly recommended that
+  you perform your own tests for correctness when using this layer.  The
+  cargo-ptests bbclass has been backported to potentially assist with
+  doing so.
+- cargo-update-recipe-crates.bbclass has been backported with a tweak to
+  use host rather than native Python since kirkstone does not have a new
+  enough Python (3.11 is required).  Using the update task in the class
+  will fail unless the host environment contains Python 3.11 or newer.
+- The newer version of librsvg from master has been backported since
+  there is not a straightforward way to update the existing one via
+  bbappend.  Backporting a working recipe should be easier to maintain
+  than developing an update of the older recipe in kirkstone.
+- A newer cairo recipe (1.18.0 as of August 2024) has been backported
+  to enable building librsvg 2.57.1 and newer.  It is believed this has
+  minimal impact on other cairo users.
+- python3-cryptography has been left alone since the recipe in kirkstone
+  still works with the newer toolchain, and updating it seems to have
+  more potential impact due to upstream API changes and its known to be
+  finicky build.  This may change if sufficient rationale for doing the
+  backport becomes apparent.
+- While changes to Rust recipe and class files related to oe-selftest
+  support are included by necessity, no effort has been made to backport
+  the actual addition of Rust to oe-selftest, as that is considered too
+  invasive and maintenance heavy.
+- To include Rust support in a SDK, do the following in e.g. local.conf:
+  ```
+  TOOLCHAIN_HOST_TASK:append = " packagegroup-rust-cross-canadian-${MACHINE}"  
+  TOOLCHAIN_TARGET_TASK:append = " ${@multilib_pkg_extend(d, 'libstd-rs')}"
+  ```
+  Overriding populate_sdk_base.bbclass to avoid needing to do this seems
+  too invasive for this layer.
+- The intent is to track any further upgrades that occur in the master
+  branch of oe-core, with an expected end of support in April 2026, the
+  same as Yocto Project's planned EOL for Kirkstone (per
+  https://wiki.yoctoproject.org/wiki/Releases).
+- At present, no changes related to the addition of UNPACKDIR for the YP
+  styhead release have been backported, as it presently looks like trying to
+  accommodate them will be more effort than not.  That may change in the
+  future.
+
+Dependencies
+------------
+
+This layer depends on:
+
+- URI: git://github.com/openembedded/openembedded-core.git  
+  layers: meta  
+  branch: kirkstone
+
+Contributing
+------------
+
+The yocto-patches mailinglist (yocto-patches@lists.yoctoproject.org) is used
+for questions, comments and patch review. It is subscriber only, so please
+register before posting.
+
+Send pull requests to yocto-patches@lists.yoctoproject.org with
+'[meta-lts-mixins][kirkstone/rust]' in the subject.
+
+When sending single patches, please use something like:
+git send-email -M -1 --to=yocto-patches@lists.yoctoproject.org --subject-prefix='meta-lts-mixins][kirkstone/rust][PATCH'
+
+Note that changes that are not direct backports from oe-core master branch, or
+are not fixes for a demonstrated build breakage against Kirkstone are unlikely
+to be accepted.  Functional changes should be submitted and merged to oe-core
+master branch first.
+
+Maintenance
+-----------
+
+Layer maintainers:
+Scott Murray <scott.murray@konsulko.com>
-- 
2.46.0


