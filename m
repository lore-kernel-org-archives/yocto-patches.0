Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB28108E1ED
	for <webhook@archiver.kernel.org>; Thu, 19 Mar 2026 11:20:37 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8661.1773919232954514345
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 19 Mar 2026 04:20:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=pmp53aZp;
 spf=pass (domain: konsulko.com, ip: 209.85.222.182, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8cd8c6e365eso90831985a.0
        for <yocto-patches@lists.yoctoproject.org>; Thu, 19 Mar 2026 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1773919232; x=1774524032; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KxbVKIB187sqaID98U6fuPEXhKVWxGNMqbuE6FaP1r8=;
        b=pmp53aZp8lnm/soW8PJgVFLQMHEIfumrX+fP9dTqZVspm9DRixqyDuQ6ExDM6i0Tfw
         zfC+Y6exO0xHnQhaG4qniU1b4aczJsjAmzr1BgFMMmdL76GNuoGmS2Vnh9T1/hL4fSpo
         oj48VyJAKACvV6JDpBLDPUhqc24ah5fkCGepc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773919232; x=1774524032;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxbVKIB187sqaID98U6fuPEXhKVWxGNMqbuE6FaP1r8=;
        b=YbagbfiPediT/Vg/pI7L6VWX0yQa0QXJQ8/hEUeVYyye5hNdYQXbq0mC7kPsdcj67F
         opBoz3n48VxmPx7j32BnSFwaizy1nQVoeya9NUvLzyW7ncolCOCNp1EnXlYmOaNAkpdM
         xTRtZ3WvHqHzS/M7THT2LzrAO7jQeiu5l5dAzDWlGnUZiDfXpJaaq1gRczJ1kejU7RaG
         FEOD4+8TCeXnzKiK0OOxGlQHZ8Wh0rUjnk1V/wQwRst4I/aKulz1bNr9TOY5iAzpIn/v
         HoU9CsIdLlo7/rqvvTESQeOJHXWeT1kqbWphU2O024xiC/5/LRhw0IJGzQwE2QJXM5bz
         nE3w==
X-Gm-Message-State: AOJu0Yw3/5ogxdhAaT09Nh9rwOyvZm5AT/wdMEA6Qe2V7DuXN5TrCqY1
	VBoU/Q43UB/2fg1WgvWmIyraPbebKB3kqqObkkHVFP4qY/80782Cy24ktzf1WJdbRtw=
X-Gm-Gg: ATEYQzwMMrkePtMJKgpmz57dBnglO+yuQoPAcMRhbwIeFOqWWZkRN7c/C8lsYDGtg3R
	05jJP20xSION0Tj5Oqs8LE0WWC+lC8A+5wF1bi0kO060ZrB31g5avhqptuEyTAniL8H31Zfc9th
	bY+hfacG4MsKG32Cyek00P+JEXArCCXXdKABkHyAcSbyUvjXEf/4xRGfhSqZxFUpm70kXZ005H3
	nUgXMM14ttBUMFYhbfwzpWWgxI+gOPxb/5SlJ0UWm9ej2E3k+wTdnRlqFdF1rLH/gwjGnsfzufK
	1n3Rmd1h1pZsX943ZWQVtMbBVOxJWidgTa0DTXvyF8Thv/LExh25L+cY+oEcqm1WuwkTwHxq+En
	gYETko1e6yhWUW542PWFoacp4XtnK1V+TJ7hZLbmaHyDj2YKE06yT76jmqt0EPSIIhu9kF5IXuR
	WUSOhDP8dd/yVGV0pREmUVyZRTb5vUhl6M8ThWkCC9D5MxoyQM+wWKyuSM/wnQjm9tQC7icGHBu
	Ry6sdcNiMlVzvX6kVIFJnPeX1OsXxDVQx6LoOe9NeM6THA=
X-Received: by 2002:a05:620a:400b:b0:8cd:e189:535b with SMTP id af79cd13be357-8cfad260d85mr957132785a.31.1773919231621;
        Thu, 19 Mar 2026 04:20:31 -0700 (PDT)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b8de534sm42302086d6.10.2026.03.19.04.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 04:20:30 -0700 (PDT)
Date: Thu, 19 Mar 2026 07:20:30 -0400 (EDT)
From: Scott Murray <scott.murray@konsulko.com>
To: Hitendra Prajapati <hprajapati@mvista.com>
cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-security][scarthgap][PATCH] suricata: Fix CVE-2026-22262
In-Reply-To: <20260309115038.329072-1-hprajapati@mvista.com>
Message-ID: <9d09b303-3391-97b2-6290-88a2dee5083c@konsulko.com>
References: <20260309115038.329072-1-hprajapati@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 19 Mar 2026 11:20:37 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3521

On Mon, 9 Mar 2026, Hitendra Prajapati wrote:

> Pick patch mentioned in NVD report [1]
>
> [1] https://nvd.nist.gov/vuln/detail/CVE-2026-22262
>
> Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>

This is probably better solved by upgrading to 7.0.15 in master and
scarthgap branches.  I'll look at it in the next week if no one beats
me to it.

Scott

> ---
>  .../suricata/files/CVE-2026-22262-01.patch    | 42 ++++++++++++
>  .../suricata/files/CVE-2026-22262-02.patch    | 66 +++++++++++++++++++
>  recipes-ids/suricata/suricata_7.0.13.bb       |  2 +
>  3 files changed, 110 insertions(+)
>  create mode 100644 recipes-ids/suricata/files/CVE-2026-22262-01.patch
>  create mode 100644 recipes-ids/suricata/files/CVE-2026-22262-02.patch
>
> diff --git a/recipes-ids/suricata/files/CVE-2026-22262-01.patch b/recipes-ids/suricata/files/CVE-2026-22262-01.patch
> new file mode 100644
> index 0000000..de54c28
> --- /dev/null
> +++ b/recipes-ids/suricata/files/CVE-2026-22262-01.patch
> @@ -0,0 +1,42 @@
> +From 32609e6896f9079c175665a94005417cec7637eb Mon Sep 17 00:00:00 2001
> +From: Philippe Antoine <pantoine@oisf.net>
> +Date: Mon, 17 Nov 2025 13:27:54 +0100
> +Subject: [PATCH] datasets: explicitly errors on too long string
> +
> +Also avoids stack allocation
> +
> +Ticket: 8110
> +(cherry picked from commit 0eff24213763c2aa2bb0957901d5dc1e18414dbf)
> +
> +CVE: CVE-2026-22262
> +Upstream-Status: Backport [https://github.com/OISF/suricata/commit/32609e6896f9079c175665a94005417cec7637eb]
> +Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
> +---
> + src/datasets-string.c | 9 +++++----
> + 1 file changed, 5 insertions(+), 4 deletions(-)
> +
> +diff --git a/src/datasets-string.c b/src/datasets-string.c
> +index 0a8f499..524a60a 100644
> +--- a/src/datasets-string.c
> ++++ b/src/datasets-string.c
> +@@ -49,12 +49,13 @@ int StringAsBase64(const void *s, char *out, size_t out_size)
> +     const StringType *str = s;
> +
> +     unsigned long len = Base64EncodeBufferSize(str->len);
> +-    uint8_t encoded_data[len];
> +-    if (Base64Encode((unsigned char *)str->ptr, str->len,
> +-        encoded_data, &len) != SC_BASE64_OK)
> ++    if (len + 2 > out_size) {
> ++        // linefeed and final zero
> ++        return 0;
> ++    }
> ++    if (Base64Encode((unsigned char *)str->ptr, str->len, (uint8_t *)out, &len) != SC_BASE64_OK)
> +         return 0;
> +
> +-    strlcpy(out, (const char *)encoded_data, out_size);
> +     strlcat(out, "\n", out_size);
> +     return strlen(out);
> + }
> +--
> +2.50.1
> +
> diff --git a/recipes-ids/suricata/files/CVE-2026-22262-02.patch b/recipes-ids/suricata/files/CVE-2026-22262-02.patch
> new file mode 100644
> index 0000000..93e6546
> --- /dev/null
> +++ b/recipes-ids/suricata/files/CVE-2026-22262-02.patch
> @@ -0,0 +1,66 @@
> +From 27a2180bceaa3477419c78c54fce364398d011f1 Mon Sep 17 00:00:00 2001
> +From: Philippe Antoine <pantoine@oisf.net>
> +Date: Tue, 25 Nov 2025 14:43:18 +0100
> +Subject: [PATCH] datasets: allocates on the heap if string base64 is long
> +
> +Ticket: 8110
> +(cherry picked from commit d6bc718e303ecbec5999066b8bc88eeeca743658)
> +
> +CVE: CVE-2026-22262
> +Upstream-Status: Backport [https://github.com/OISF/suricata/commit/32609e6896f9079c175665a94005417cec7637eb]
> +Signed-off-by: Hitendra Prajapati <hprajapati@mvista.com>
> +---
> + src/datasets-string.c |  4 ++--
> + src/util-thash.c      | 21 ++++++++++++++++++++-
> + 2 files changed, 22 insertions(+), 3 deletions(-)
> +
> +diff --git a/src/datasets-string.c b/src/datasets-string.c
> +index 524a60a..53a179a 100644
> +--- a/src/datasets-string.c
> ++++ b/src/datasets-string.c
> +@@ -50,8 +50,8 @@ int StringAsBase64(const void *s, char *out, size_t out_size)
> +
> +     unsigned long len = Base64EncodeBufferSize(str->len);
> +     if (len + 2 > out_size) {
> +-        // linefeed and final zero
> +-        return 0;
> ++        // linefeed and final zero : signal we need more space
> ++        return len + 2;
> +     }
> +     if (Base64Encode((unsigned char *)str->ptr, str->len, (uint8_t *)out, &len) != SC_BASE64_OK)
> +         return 0;
> +diff --git a/src/util-thash.c b/src/util-thash.c
> +index 5486379..c6df02c 100644
> +--- a/src/util-thash.c
> ++++ b/src/util-thash.c
> +@@ -390,7 +390,26 @@ int THashWalk(THashTableContext *ctx, THashFormatFunc FormatterFunc, THashOutput
> +             char output_string[1024] = "";
> +             int size = FormatterFunc(h->data, output_string, sizeof(output_string));
> +             if (size > 0) {
> +-                if (OutputterFunc(output_ctx, (const uint8_t *)output_string, size) < 0) {
> ++                if (size > 1024) {
> ++                    // we did not provide enough space on the stack, let's allocate on the heap
> ++                    char *out_alloc = SCCalloc(1, size);
> ++                    if (out_alloc == NULL) {
> ++                        err = true;
> ++                        break;
> ++                    }
> ++                    size = FormatterFunc(h->data, out_alloc, size);
> ++                    if (size == 0) {
> ++                        err = true;
> ++                        SCFree(out_alloc);
> ++                        break;
> ++                    }
> ++                    if (OutputterFunc(output_ctx, (const uint8_t *)out_alloc, size) < 0) {
> ++                        err = true;
> ++                        SCFree(out_alloc);
> ++                        break;
> ++                    }
> ++                    SCFree(out_alloc);
> ++                } else if (OutputterFunc(output_ctx, (const uint8_t *)output_string, size) < 0) {
> +                     err = true;
> +                     break;
> +                 }
> +--
> +2.50.1
> +
> diff --git a/recipes-ids/suricata/suricata_7.0.13.bb b/recipes-ids/suricata/suricata_7.0.13.bb
> index 75e523e..728c7f1 100644
> --- a/recipes-ids/suricata/suricata_7.0.13.bb
> +++ b/recipes-ids/suricata/suricata_7.0.13.bb
> @@ -16,6 +16,8 @@ SRC_URI += " \
>      file://suricata.service \
>      file://run-ptest \
>      file://0001-Skip-pkg-Makefile-from-using-its-own-rust-steps.patch \
> +    file://CVE-2026-22262-01.patch \
> +    file://CVE-2026-22262-02.patch \
>      "
>
>  inherit autotools pkgconfig python3native systemd ptest cargo cargo-update-recipe-crates
>

