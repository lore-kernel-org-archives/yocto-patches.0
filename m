Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EA7D1953D
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 23:55:21 +0000 (UTC)
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35792.1769471711531839584
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 26 Jan 2026 15:55:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=lUdKOPLw;
 spf=pass (domain: konsulko.com, ip: 209.85.219.66, mailfrom: scott.murray@konsulko.com)
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-8946a794e4fso62594266d6.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 15:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1769471710; x=1770076510; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jx8m5aZl69l93FmORJ+VE9acRAwWGDCjXsMaUsln3kA=;
        b=lUdKOPLwj0+Kh5+atWDlBQvq7P5K5x0d1CmsLVVVkN4JVmvDQYmAG6a4FH1gmGbnTx
         POH9RMU2uaG9a7ps3ROPKtyhIKwyPQyoP7ZN+ZboLzJETINwZdwMX/HOZXsKPDEPeYdy
         7U5neob3PvpOMbuP3B0yiF7I5dyRXg8HP+4Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471710; x=1770076510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Jx8m5aZl69l93FmORJ+VE9acRAwWGDCjXsMaUsln3kA=;
        b=iU0OGb9ui7sT6i9URUEynjRalQxrHJ36LkU2NuJzW5fO7secnk+hysloWW0stJT85C
         TX2nbiFgiCXBirj6aygy/rjdwk6GK8XtOj6El+COQ1BU7l416ATrWhlIG4tAH0GnWYEh
         vKE9tMVpp3UkIVffmqaqktftzcU+GXnNKkjINMpPSJP5CRV+9XiOCe+aDUsDW19cMf9c
         GwNghWEEcx1+f8c8E7qqNQvJlfCPhq9gemRpV6iGneC8jpIMOgdyEXTbOY4bEu6G/GDy
         vseVOq6Bi9Gy7hqss4VAYK9QtceKfvnrZ3yMP4aKzT6Ipiw6OWXGw/qW9D21nlJ49Nxs
         CD0Q==
X-Gm-Message-State: AOJu0YwggRqBdD50CIBGGXolGWxT4TksBV6Q3lLnIrFuoQuTOdl03Y3Y
	1FIk0HL4ttgp4bmIfyWjlsqkhoIXtHmZCdaJcHGUi5KHuBalxCPsN3o4wjZmUT8KprIq1DGQNfY
	9cOE+tScIUA==
X-Gm-Gg: AZuq6aI8JqIXhWtjJvafOFe3FMmiY+LKEJej3wvKnl//QD/XR7thXqV1kXktW4Fr5vL
	RGOP3qwk1+cOIPZ1lbUtAJeYxirEA9hAEda+rjJrSutf2QFE44cSURXXSfupoGxntXDLmwPUztU
	w3sK7DDAKiqVW7m98ErZ+BOUz73esXNfNl5EzOiuvsqoM3X1IndjzVf/UfqweQprAe8jeQrkCRz
	7112mN5U/jVKNjCy2t8hqJ7T0IiOxGoFNQqSmzlLTD7gNojRa9CfxUUoCR2TM62Oiw1Lf/w+dAW
	pQsjFQw7uyIQFsn/MSmrxwCM29yh6aFFD/wuvVMWRz4gWICzEvOAp52+BwjprBQW10v2Re1cnnq
	SmjEyHt6wp8XVvt576dIRFmPWOzhdj2ZtowiLWU1sko1eOdxWpv7T4HlNX8h21iZHJHw26vwR1G
	EInwDJ0iTdmv0obVSVlRzLg5oJV8KeWygBAWgZhu4FIvIgS6LbpTCkpCzXn7GdWgA/W3K0duvbl
	ljZfgQcy+nYxdRITohjh1danSo4Dygwvb6w+Rn9iE0D92krZ5sqDhHB/5RFY0E=
X-Received: by 2002:a05:6214:21e3:b0:88f:ca79:844a with SMTP id 6a1803df08f44-894b0782eb4mr85590576d6.48.1769471710137;
        Mon, 26 Jan 2026 15:55:10 -0800 (PST)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37d1f14sm1061740885a.15.2026.01.26.15.55.09
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 15:55:09 -0800 (PST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 09/10]  rust-target-config.bbclass: add RUST_TARGET_ABI to sstate signature exclusions
Date: Mon, 26 Jan 2026 18:54:55 -0500
Message-ID: <1c0954ab5b2069e14e6549300bbec1dd4b0ab9ee.1769471543.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1769471543.git.scott.murray@konsulko.com>
References: <cover.1769471543.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 26 Jan 2026 23:55:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3111

From: Alexander Kanavin <alex@linutronix.de>

This was overlooked in
https://lists.openembedded.org/g/openembedded-core/message/218953

and caused non-reusable sstate for rust-native when
the target is one of risc-v machines.

[YOCTO #16132]

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(adapted from oe-core commit 9993e62f35c96aa8fce39a583f6cc391c0cbba99)
Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 classes/rust-target-config.bbclass | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/classes/rust-target-config.bbclass b/classes/rust-target-config.bbclass
index 4fa8a85..bfa4adc 100644
--- a/classes/rust-target-config.bbclass
+++ b/classes/rust-target-config.bbclass
@@ -416,7 +416,7 @@ def rust_gen_target(d, thing, wd, arch):
         json.dump(tspec, f, indent=4)
 
 # These are accounted for in tmpdir path names so don't need to be in the task sig
-rust_gen_target[vardepsexclude] += "ABIEXTENSION llvm_cpu"
+rust_gen_target[vardepsexclude] += "ABIEXTENSION llvm_cpu TUNE_RISCV_ABI"
 
 do_rust_gen_targets[vardeps] += "DATA_LAYOUT TARGET_ENDIAN TARGET_POINTER_WIDTH TARGET_C_INT_WIDTH MAX_ATOMIC_WIDTH FEATURES"
 
-- 
2.51.0


