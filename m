Return-Path: <akuster808@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4E8C7EE2A
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 20:27:10 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.web11.5130.1750710423321178964
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 23 Jun 2025 13:27:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=DzY1qOpM;
 spf=pass (domain: gmail.com, ip: 209.85.128.182, mailfrom: akuster808@gmail.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-70e75f30452so33321397b3.2
        for <yocto-patches@lists.yoctoproject.org>; Mon, 23 Jun 2025 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750710422; x=1751315222; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CBTIh+QDwGvhlRHXaiAF2mCZCTDq42eTXpy+q7LaeK4=;
        b=DzY1qOpMbT3ll10K+lwmyVQ7ArjMIpixYOOnqgEvFByyPEaCbCb0WdqP1dkzeCzpUo
         RsCPgvfnXOBum2RGmUyizBcRfN6VFETW0e+I7P+WZi5nRoMTSz94UaXkB4pfjjSXNkOc
         SXa8B0JxGkDlMGP09klnWbdZZP7dkmOp+8eGEeCSRZz45FCZg+ZjQBy7GN2CUCywyV9F
         McoGdo5rJdl8MeEmfsHFmZcyutI+Md6+kgFDn+U2H7ZMLBRdU6a2ot9YXjprzZ0PV/9f
         a2HOI62iv8UDhybeGD7e744Gt1dN/49U5Hv5M6rozqeI9fkV3wAlqWS4ciLjFePttbt3
         /igA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750710422; x=1751315222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBTIh+QDwGvhlRHXaiAF2mCZCTDq42eTXpy+q7LaeK4=;
        b=gnmmQ0WAyjVnJxLGAPP+nXsKQ8IvkDjDWGixGQiw0NPZmwFHSgpr32gbjDsIoN7qI6
         3VXJGWKU81jPcM5LuCyAXjk0Q6hkRz2cSEQE2HOUoIM4MoPWSVHEEg6PwWMOnblKEn0U
         dlgz16bbgoU9JsP4wMNFuSksDDsNN/vZVk0vMME98Yvhr56jb4Y/FXgnnhP4JQPWkVCu
         f8tr0m9KIgT3y5pzTbxzf4JdKVqmk8LVIg4xkaNj0OfF1LwSsLIJva+oCsQdLMO3AGJB
         mBbaRK+/PoEssMo165BokIpWv/ieWpAJfkj+/vPix5zhu1tzAXpHJVI2Z3+dzi4icVe9
         uWpA==
X-Gm-Message-State: AOJu0YwNsdhSDwsDuD8NCUzXofOOw4TBtkS6LZwZV8QxLsSki6Tuu1/Y
	U7gV/etbaQuGn1KB1uHSQsuT7eqGjVZXGpzbkL+Q3ESZ1UVWlwq32ekT6afCdCLf
X-Gm-Gg: ASbGncsmxG1DfWeqh6fdLbOkNXmrAc2ghHEMZcEif7vO9CiSIAcrZyfVcFDbsYt2qGg
	TaRDtVW6Vylz+Cwr+1BAIxw3Iw9Tg9b6Cs4zjtYThuI2NY7t6n9BSZJTelGIgh9dPk+iUlvSs1K
	/Tu3AresRJuHVcKukCUFA894FRkeb+cgKLM2B/VF+OQawUPssWeyjI0zrs2vxlTHl4fkgLNSUtI
	h8PB9u/NV+b3xZWcBGi8fNGG2aevBNUNeGqPeTmtr0Yp52iYt7jUzYR26HWNZ4P3thly2emIXIM
	Di3zNdsh0UgxkN1fBTe06YN8sgWuun0+VROTfIl/1jevqSwxaRuFnvJb3kO0FrZgWvzac5hl8d3
	6
X-Google-Smtp-Source: AGHT+IGcDHrkCH9sXZsvYZGndpqoEpgg+ClIRTKt5SWM6hjyqa0GDlRk8ZcTq8jyiDeZlco40aK1VA==
X-Received: by 2002:a05:690c:3349:b0:6ef:5097:5daa with SMTP id 00721157ae682-712c679b226mr192758537b3.34.1750710422126;
        Mon, 23 Jun 2025 13:27:02 -0700 (PDT)
Received: from keaua.attlocal.net ([2600:1700:45dd:7000:e6c8:e7b0:d1b0:fa65])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-712d93f990csm11142037b3.50.2025.06.23.13.27.01
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 13:27:01 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: [meta-security][PATCH 0/1] Time to move on.
Date: Mon, 23 Jun 2025 16:16:45 -0400
Message-ID: <20250623202701.12590-1-akuster808@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 23 Jun 2025 20:27:10 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1678

I have been maintaining this layer for over 12 years and
I have had a blast being a layer mainter over those years.
Thanks for giving me the opertunity.
Its time to pass on the baton for maintanership of this layer. 

I'll let the The Yocto Project TSC decide who the suitable replacement(s) may be.

Armin Kuster (1):
  Remove self as Maintainer

 README.md                | 2 +-
 meta-hardening/README.md | 2 +-
 meta-integrity/README.md | 2 +-
 meta-parsec/README.md    | 1 -
 meta-tpm/README.md       | 2 +-
 5 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.43.0


