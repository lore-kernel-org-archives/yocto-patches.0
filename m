Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74493CE8D69
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 18:05:46 +0000 (UTC)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4702.1763143538150426442
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 14 Nov 2025 10:05:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=nLMjW0Q6;
 spf=pass (domain: konsulko.com, ip: 209.85.219.54, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-88044caaa3eso20366376d6.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 10:05:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1763143537; x=1763748337; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gj+Wgp1QcpYJ6R6a9Mzm7UHcgf92mzxN2a2/p/xGUl0=;
        b=nLMjW0Q6Ql3oUzHYR6/qXStNIpa6JIEeUIdLWD/s4pSQAPFQm7U62Tw7NdfNcfwD+G
         vTQF8M2gxuIe4QxuNYbAYTdhhdbVZR+aOK2oS4bom3WqFZ7Th9Mrg2HwzotqDV2d7akN
         z2IcC/Q5ihi2E06Myl9yAVpNVWM5sRMlOQDWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763143537; x=1763748337;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gj+Wgp1QcpYJ6R6a9Mzm7UHcgf92mzxN2a2/p/xGUl0=;
        b=i3NdIn5RdzhmzSLz8kzQmx7oepE64uEgcafFyTgTDboS0eIGNe/6wfplsqD0GdNhe3
         Ld7ti/cg2YZ0XEQUb6WfWQQcM4OT28b7et/0Jv1fnS1mWR4gwRTQq42A6w914nhyAOcQ
         RdSh/zWlrX5WjLTuMYESIh263krKZjesAxjFdaqvS5Sp0IEo42LCgdTmj3ZNlFrP4OgS
         KAAe1teBR61k4m364xijmQkyYM8yob9jnV+fAbSznubniYpUORE55n0/08ezzkxdOU/B
         tLDHypECk5J1b88BE1Q+FXvxWlz2Bh4GH68rV2SmyK+Ssyesg8rr1dRKBb/X6fNj8JdG
         +Ccg==
X-Gm-Message-State: AOJu0YzGkLCjSGAxKjyoNPFL75jTDtRLVtf5dj8j6J+cs2TpWw5lKAWL
	Ezq1jYu3PLxcy3BS8UDeivrZPXyu6aHDnE5UbM/U+ErW85Zwdo50vAkNGmelYO5mclw=
X-Gm-Gg: ASbGnct3CMa96XATFNVNpM1cbaFrN5hv2vpUquIg+Et6cDwTL8BBIRodJRhIJQVba8I
	qvioyK1WY8pJoQBlC0pKeOftdunQ3el5ne1kF9Prd03KmbUVx+45BgUq3dbS1x5aQvuuM93hwlp
	MP8KvjUNN/+zYLi8J+2ylJAMwBMiurc0wVDzesxhvAV5jC5QL1e8keEudLz8VnRFdthZf1VD19V
	2n7nfJG2FOygykg2bN1AkC+5FCNKDIcLMraZz3c+lAOstGP6xaVtRg9MPWQqYo/MYSibPnSvfZm
	WM+HUiW59FwB5uuw9uXFCm3KqIQjgAjESrvhu5xDKF6wT2yZiG9oINuC4hLD7grslG3LJEYUR55
	j5jBwIPwFDL8YhKEr9DVqjOre+8lLLrJZiaBBuHeGugveSRQq4C96l0gVLCFYEZTpdCqdCHC/9p
	HsjnHhD0W5nDYO1bqB5s0r1tYv+2stxlJXWlQ=
X-Google-Smtp-Source: AGHT+IGBr+ZKqikSb7PEUrHIUneGg1KOdsMdKMbMHLO6zxsrOO1U9lu/czMV++WpnQnvwYA9G5OL0w==
X-Received: by 2002:ad4:5c64:0:b0:87c:22eb:36b9 with SMTP id 6a1803df08f44-8829259069amr54053246d6.9.1763143536791;
        Fri, 14 Nov 2025 10:05:36 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882862c7253sm35574626d6.5.2025.11.14.10.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 10:05:36 -0800 (PST)
Date: Fri, 14 Nov 2025 13:05:35 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: hemant.jadhav@emerson.com
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH v4 1/2] clamav: Add recipe
 for version 1.4.3
In-Reply-To: <20251114154052.3651845-1-hemant.jadhav@emerson.com>
Message-ID: <58f6364a-0faf-9296-588e-1798cb52653c@konsulko.com>
References: <20251114154052.3651845-1-hemant.jadhav@emerson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 14 Nov 2025 18:05:46 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2571

On Fri, 14 Nov 2025, Hemant Jadhav via lists.yoctoproject.org wrote:

> Major changes in 1.4.3:
> - Upgraded core engine with improved threat detection capabilities
> - Added Rust components requiring cross-compilation support
> - Updated CMake build system replacing legacy autotools
> - Modernized library dependencies (LLVM, JSON-C, PCre2)
> - Added comprehensive license compliance for multi-component package
> - Enhanced cross-compilation support for all target architectures
>
> The recipe leverages cargo_common class for automatic Rust toolchain
> configuration. ClamAV uses both CMake and Rust/Cargo build systems,
> requiring special handling to ensure both configure properly.
>
> Security rationale:
> - ClamAV 0.104.4 reached end-of-life and is no longer maintained
> - Upstream strongly recommends migration to 1.4.x for security updates
>
> Signed-off-by: Hemant Jadhav <hemant.jadhav@emerson.com>
> ---
> v4: Fix hybrid build system configuration
> - Add custom do_configure() calling both cmake_do_configure and
>   cargo_common_do_configure
> - Enable network access during configure and compile for Cargo to fetch
>   git dependencies (onenote_parser crate from Cisco-Talos/onenote.rs)

This is a non-starter, as it:
- breaks build reproducibility, which is even more important for a
  security tool.
- opens the door to build breakage if any higher-order dependency
  crates increase their required Rust version (I've seen this happen
  multiple times in the past few years).

The recipe needs to use the regular cargo.bbclass and an include file
for the crates generated with cargo-update-recipe-crates.bbclass.

Scott

> - Set CARGO_DISABLE_BITBAKE_VENDORING = "1" to disable BitBake vendoring
> - Skip buildpaths QA check for main, libclamav, and staticdev packages
> - Tested with clean build from scratch in OE-core master
>
> v3: Remove S variable that was mistakenly left in v2
>
> v2: Address review comments
> - Remove S variable (auto-detected in master branch)
> - Use cargo_common instead of rust-common (handles config.toml automatically)
> - Remove manual Cargo configuration in do_configure:prepend()
> - Change ${WORKDIR} to ${UNPACKDIR} for file path references
>
> v1: Initial 1.4.3 upgrade
> ---
> ---
>  recipes-scanners/clamav/clamav_1.4.3.bb       | 209 ++++++++++++++++++
>  recipes-scanners/clamav/files/tmpfiles.clamav |   1 +
>  .../clamav/files/volatiles.03_clamav          |   1 +
>  3 files changed, 211 insertions(+)
>  create mode 100644 recipes-scanners/clamav/clamav_1.4.3.bb
>
> diff --git a/recipes-scanners/clamav/clamav_1.4.3.bb b/recipes-scanners/clamav/clamav_1.4.3.bb
> new file mode 100644
> index 0000000..0cbae53
> --- /dev/null
> +++ b/recipes-scanners/clamav/clamav_1.4.3.bb
> @@ -0,0 +1,209 @@
> +SUMMARY = "ClamAV anti-virus utilities and scanner tools"
> +DESCRIPTION = "ClamAV is an open source antivirus engine for detecting trojans, viruses, malware & other malicious threats."
> +HOMEPAGE = "http://www.clamav.net/index.html"
> +SECTION = "security"
> +LICENSE = "GPL-2.0-only & LGPL-2.1-only & BSD-2-Clause & Zlib & Apache-2.0-with-LLVM-exception"
> +LIC_FILES_CHKSUM = "file://COPYING.txt;md5=2c0b5770a62017a3121c69bb9f680b0c \
> +                    file://COPYING/COPYING.LGPL;md5=2d5025d4aa3495befef8f17206a5b0a1 \
> +                    file://COPYING/COPYING.bzip2;md5=ae8d555c34b656ff864ea9437a10d3a0 \
> +                    file://COPYING/COPYING.zlib;md5=3648a0b9713ab246e11536055165a41a \
> +                    file://COPYING/COPYING.llvm;md5=c82fc668ef1809acdd0684811df93bfc \
> +                    file://COPYING/COPYING.unrar;md5=6a741ba21afc8b71aeaee3b5f86a8111 \
> +                    file://COPYING/COPYING.file;md5=e63a61022c36cff2fdfbf02dd51674bd \
> +                    file://COPYING/COPYING.curl;md5=be5d9e1419c4363f4b32037a2d3b7ffa \
[snip]

To save me from digging into this myself, can you elaborate on why
upstream now has all these license files as opposed to the one the
previous version had?  Are they vendoring a bunch of code from all
those projects now?  If so, can we disable vendored libraries to use
system provided versions?

Thanks,

Scott




