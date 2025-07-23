Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514E7C87FD2
	for <webhook@archiver.kernel.org>; Wed, 23 Jul 2025 19:05:59 +0000 (UTC)
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
 by mx.groups.io with SMTP id smtpd.web10.23094.1753297555489432866
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Jul 2025 12:05:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=f3woyEIA;
 spf=pass (domain: konsulko.com, ip: 209.85.222.170, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7e62a1cbf82so16211185a.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 12:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1753297554; x=1753902354; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBximcNYMv7mxenpbkId8rIR5OmpvqlflcWMSEeLOwI=;
        b=f3woyEIAV14xFIFp8cZ/kHGAlMDB2wSaRkWo4N6Abv03Xu4XxhtiA5H4MEj6skJkbU
         rHmhIEcz9bGIYx9IUBZ928Qj3791oGZjDbh3Y8O/eePUE3cjnUjGit9JaL+nIEB537cS
         6xd2hyFPI8VSEVI735wFwwhaqFg/4/DyFjecg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753297554; x=1753902354;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mBximcNYMv7mxenpbkId8rIR5OmpvqlflcWMSEeLOwI=;
        b=Y9SnHgtLkO8To96utITNtoEUcXmW+V8sdjwbEI+S0f55emI+ZnFEGs+nzmcnEHP/nA
         EfDI5qzcqJJk4YNf4pOGLZ3J1xMS5IUnG+Mfl9owBPJpMajeLYTbfvph29bv+HbRy5sx
         TSgnK94iPZhgotSYmttzb725Tk3BRDWYrFrEPTtsfk9CM4GXdQajuMHc6Ghm8ZbfEWN7
         nYqnO9Zkhr9Zc1tv/Xoi1U9fz/l8pe+xlDdLZvjgJG3VLf6S9vbi5j1PA91NnIPdJ9L6
         GqXPyY8ft+bwwR1f5Ra7xCQLQbpZlsQYfOiClLNrSJsMyy+vipKz48fJ/E85oREyW8f2
         0K3A==
X-Gm-Message-State: AOJu0Yzq/c/Zb2TzyaR/uDKT7ZnmqaP938ljXgLhHGaEnmsZ/2HdwuW5
	9bhS8CTERoD/usyY0NDiSrX51j8rCoM0nIC2I/zxlwPR8nJH3emSx7ABqCZh3OBGS7AOdfhHeIg
	PJNQy
X-Gm-Gg: ASbGncublFxOe7tZr8njxdveu5mdDo4XmRkzACuAwfCrj5gIE4ttNZ7WjYRrBB4hOR8
	rzEJnOYIFUlZcNYdHipaXNJV/Fy/QSNeXUHdotpDtglLnmDV0Us8WgoiZe8jfpFGvuXbh3/AzLg
	VOJ3OlS3uweIYQFnRXA3IWPvi8+pN24vsVYHjsRQ0AAgaqCsTOFypBr6sFM7yQ/ca5VYRRX4DH6
	7zQ8n8PCW6LXYhRe7Px53d6DGoe8CzD+JiG1zDRp6Hkfrmxrv6D4G+vgxTpU9zYln1pUJaqSa2x
	ty+7oGGfF6yGsBRcvi1pFxL8wFlSO4ogg3QzR08wWFKrKqwt7omtCKnrxe+6hq5Xk/KPqxPF19d
	z/rT0JoSDNRgd1Om2xSFqmKum2iL4h72q8GF8ovbT2YfDMoElWZYaR3KIqj1vu3eYmnk2aQx9Bw
	==
X-Google-Smtp-Source: AGHT+IE+yPOeRHD6Mtyym44bMiWioLVFeAfF4XlgAkbH6gHCb//in25anC7WqSNEI+scnX2phLD5ag==
X-Received: by 2002:a05:620a:7108:b0:7e3:34f3:b444 with SMTP id af79cd13be357-7e62a17ffd6mr527877885a.49.1753297554392;
        Wed, 23 Jul 2025 12:05:54 -0700 (PDT)
Received: from ghidorah.spiteful.org (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356c75cf5sm703576085a.84.2025.07.23.12.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 12:05:53 -0700 (PDT)
From: Scott Murray <scott.murray@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: soumya.sambu@windriver.com
Subject: [meta-lts-mixins][kirkstone/rust][PATCH 09/13] Make dynamic layer rust bbappend version generic
Date: Wed, 23 Jul 2025 15:05:28 -0400
Message-ID: <b07f824a615f9c0dc96f3ccb0c42e1b9baf94c4b.1753296167.git.scott.murray@konsulko.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753296167.git.scott.murray@konsulko.com>
References: <cover.1753296167.git.scott.murray@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Jul 2025 19:05:59 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1850

To avoid having to rename the dynamic meta-python rust bbappend on
every Rust upgrade, switch to a wildcard for the version.

Signed-off-by: Scott Murray <scott.murray@konsulko.com>
---
 .../rust/{rust_1.85.1.bbappend => rust_%.bbappend}                | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename dynamic-layers/meta-python/recipes-devtools/rust/{rust_1.85.1.bbappend => rust_%.bbappend} (100%)

diff --git a/dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbappend b/dynamic-layers/meta-python/recipes-devtools/rust/rust_%.bbappend
similarity index 100%
rename from dynamic-layers/meta-python/recipes-devtools/rust/rust_1.85.1.bbappend
rename to dynamic-layers/meta-python/recipes-devtools/rust/rust_%.bbappend
-- 
2.50.0


