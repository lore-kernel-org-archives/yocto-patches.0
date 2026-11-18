Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.5143.1795030969219826791
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 18 Nov 2026 11:42:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=FIjUyQBv;
 spf=pass (domain: konsulko.com, ip: 209.85.222.172, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9495e8ae239so168256185a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 11:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1795030968; x=1795635768; darn=lists.yoctoproject.org;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lvE/XQXB2h1wqGTeZI7sUtBsJKSD/q3F6dTM0YkPYc8=;
        b=FIjUyQBvTNj8i2OLtF4dT4pFjrbyrBIhCYd9D0mkve1n2lio+lRulpvWbJZCFaqgSH
         Jb8Jhex+G3ibocmKCwz0EMrPM7q3aRAG9gvxqr+wbsMYCvKoiqrD8XftSqYGYjy1wuvD
         uZl/m4SVmbFS4Tmmg9yDLurzEPQr8Z0VvTL/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795030968; x=1795635768;
        h=content-type:mime-version:references:message-id:in-reply-to:subject
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lvE/XQXB2h1wqGTeZI7sUtBsJKSD/q3F6dTM0YkPYc8=;
        b=BFwV0BvEtkmtwH8Sgtid627fNrzwfHKNt3+JJt5MVzsGu7TjQyDXeCfecDnTKwDCck
         rCf6TnT8Z+4axp3wisTe+LvaCvIg/vZCk8Cw6W0ymrHy7jFTwrBcWthCmQtsdb1TexX6
         WvC1aBJheel2TQRbbqQxoqU7kioeuDam8CZ00TE3MipgCh3J9w3IhHFnhE3x8afYk0Aa
         BeDdyBq/X+KCfG4xtoCAbrmLbArcN2Q5pR0t/wYvvDZDlFJDMMktUcEBzpB8TOMPrrA9
         P98Jljtpx/uIEZ2Pnuexf9IZDOKhO1BSc8gtsFMjv18d+U1ImNwjJmSsVT71bW5TzZFU
         QiDA==
X-Gm-Message-State: APuU4Z+L4VAQtynzW4k5D3xzBcpBcztqAGbqUc91dKSHMLOtYYiLGtUV
	kqFBAmMeOPuJOGQ1xbDuMBIoFpLV2r7Eyliha2xAaIl0FvesHDM20V0jokwmu4ncGbjmh4cV235
	qyQh54yk=
X-Gm-Gg: AYBFou1G69kgcD3TWxn7U7exGCDneXc84h2I/gD7BpSDeUGq9/vyhmqF9uAtSRp/6+c
	UeOE0xPkLrv6fa1o2srNdpn+3W+CUBedqrClsttIM5vyp2RWlhIAERV1lNQBNoPn/prEeEcO7IL
	KlZ+xuAsZrqaZg7tye3Rv2vprfISYEAYFRvHKbR98pdB2HfIMOplHCmw5tCGelVdF0tcyUbMONA
	hchVnQnxexUXFtCD6lkIvBUDTwPjK5imAJE0KGyS/eKmODCVIhxUKFcGgeWWBZxqVjRniqhJGtV
	EuzyF8edk9AkF7YSOvdR79x5/rtLFZJBUhJcbcwS0VMBR/Xi4xOtUL3osdetsIByY7PkjoXW5kl
	4o3+PoW1q60FUDLZHeAW6WQmx0H2pvILX4Jp5l7UGBLg+bo24BagvvubrGRa67nsfJsfinNab74
	DSZHXiTyMb72+SFGkNU6jbYH5Ma606GtsTVVnK/iEs1gfOwJLzXwEOzoparrb4T4zlPWD2IvnmR
	cUv12MHeonP2n0/fQymAk9lwobmM3SS61ZNoba63hfW6Ns+dXpj7Wa3KBDmiPk6n6A5Vvoll0ON
	uYju7qxco5BYlfV2K7OZMZZ5qeYmWgo8YQhb8GXtwVG/rA2PcGJEx/hDp99Mys9rJdpN7llOoQu
	3oxa40E3In7UIDAXpAlt/tTm3CgEcZv6vrInGNMaKR3LcoIOw+yNBz+Xu
X-Received: by 2002:a05:620a:4088:b0:949:402b:f1b3 with SMTP id af79cd13be357-9499962dd00mr623602185a.70.1795030967924;
        Wed, 18 Nov 2026 11:42:47 -0800 (PST)
Return-Path: <scott.murray@konsulko.com>
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b721ccbsm258717585a.10.2026.11.18.11.42.47
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 11:42:47 -0800 (PST)
Date: Wed, 18 Nov 2026 14:42:47 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-security][PATCH 0/2] A couple of small
 updates (11/16)
In-Reply-To: <18E8A6444CE1F506.1248965@lists.yoctoproject.org>
Message-ID: <fd9eb3cf-d221-ae91-90f2-454919c51831@konsulko.com>
References: <18E8A6444CE1F506.1248965@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <yocto-patches@lists.yoctoproject.org>; Wed, 18 Nov 2026 19:42:53 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5476

On Tue, 17 Nov 2026, Scott Murray via yocto-patches wrote:

> These are a couple of small build fixes to get clean builds on master
> after some recent oe-core changes.  I have pushed them to master-next
> if you want to try them locally, and plan to merge to master by end of
> day tomorrow (11/17, EST) if there are no objections.

These have now been merged to meta-security master branch.

Scott


> Changes:
>
> Scott Murray (2):
>   tpm2-openssl: Fix building with OpenSSL 4.1.0
>   dm-verity-image-initramfs: Fix IMAGE_PREPROCESS_COMMAND
>
>  ...key-fix-compilation-with-OpenSSL-4.1.patch | 87 +++++++++++++++++++
>  .../tpm2-openssl/tpm2-openssl_1.3.0.bb        |  1 +
>  .../images/dm-verity-image-initramfs.bb       |  2 +-
>  3 files changed, 89 insertions(+), 1 deletion(-)
>  create mode 100644 meta-tpm/recipes-tpm2/tpm2-openssl/tpm2-openssl/0002-pkey-fix-compilation-with-OpenSSL-4.1.patch
>
>
