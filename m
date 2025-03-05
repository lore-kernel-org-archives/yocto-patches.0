Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E07C19F32
	for <webhook@archiver.kernel.org>; Wed,  5 Mar 2025 10:25:21 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.web11.10284.1741170313825134351
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 05 Mar 2025 02:25:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=dUiWWAzV;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43996e95114so44756475e9.3
        for <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 02:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1741170312; x=1741775112; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G8FxDQ20iuWMoa/PNqVHP3/KOFuVca5cpYuJCl8cuXI=;
        b=dUiWWAzVoswGfA3JUBeMGlRkPh71HSVyOUtPEHaYsXKdhja9+kVrjgZH8e5alFI/Gx
         wa+vfIoJHmAuz0otmdG3AAAdoYIHUtRzB1TsgkuVsq0cGl+vtnWJlNcIDRSLjNXYWXIR
         wDmnkL1sKHx06iYiYe7xpinnNHPGtxGDMOZ/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741170312; x=1741775112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8FxDQ20iuWMoa/PNqVHP3/KOFuVca5cpYuJCl8cuXI=;
        b=HOFvl7elUSodc4zG7vHPwotkCVkTyOy7kyKX3jimg8ojKSXl3rltcwiS3w4/9Jo64E
         pY6qUWnKkMzMwFUV2+leQbemitQtb4KYe9vFWHdSwo2B65/JtvUpfJI0A7bgsCkKLiUy
         HyXcYwu6ORsyv9p3kSJBqSLOgHLA3Lw/Aa0Bk/o66ouHpu9hTDNbmdi/epT32FMofa0d
         PQ4POk0ZAPd4qcih6pDMidyNFCw5MUKqtdewO2pXGlA4zPl7spGkoxjSv0cXkNrS2/Yu
         ByoJVz9fePxKqVk9tCAAcP2vrC6XoalVsHXu9er4qpG7qtzlQLWjYn1OS//jtXD5deZh
         7yyw==
X-Gm-Message-State: AOJu0Yzrw7VT9x1naGbkLGTAvCfNyamr/wZWP1XerwhtgEaO02R5iAX4
	B+1NygGOHSbuRMRKjx81Q1sUIyWAZg7T/1cSImBTQpqkkqSnaktB5cQFUuUHYxuF68SU3v6osqC
	1
X-Gm-Gg: ASbGncsfxgJHwp+H5cHRU9RjpjZH0CEbfmkuav2FNqBO6dYAxPoRJUiNurc3e5s62YT
	fmm/jqOmn2/pskLA+9CxskQASg6byRX46upQjttuJHPItxq9ni1iTWAKVT2HhI6YGLNONoN5l5L
	2QVY5i2JGI0zAlyvL46ng1VUj8dAmDC6ZgeiejzukpgmLS7aB4q/owfvO74AbG/AWqCxVkUEAIw
	ni0wKhKaEcSg81UXeB+TyCWthDmRVgyQ65n88PR0lR3nkSi9jS8v4FtbEV3POyL6cLO3rKakXrL
	PNb9gySs7TVjixhqegoAZQ5p0ja1jYQsQCdqC4siD1bmgmJuLYYWqkwzDImewJhYVQWQFYgorQ=
	=
X-Google-Smtp-Source: AGHT+IGIpLP2EMdNYZGhvC3JOqJTTi9eV5W7N5W362gEcFLbF7RXNdpyYojtP47tSdbKSbHFJrGezw==
X-Received: by 2002:a05:600c:4f06:b0:439:9f42:8652 with SMTP id 5b1f17b1804b1-43bd296df39mr17595975e9.17.1741170311767;
        Wed, 05 Mar 2025 02:25:11 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:939e:c44d:2366:e8da])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4352eb1sm12973495e9.31.2025.03.05.02.25.10
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 02:25:11 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Subject: [yocto-autobuilder-helper] [PATCH 04/11] scripts/run-dashboard-index: Ensure failures show an error
Date: Wed,  5 Mar 2025 10:24:59 +0000
Message-ID: <20250305102506.2043524-4-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
References: <20250305102506.2043524-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 05 Mar 2025 10:25:21 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1148

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 scripts/run-dashboard-index | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/run-dashboard-index b/scripts/run-dashboard-index
index 7309158..47c5e9a 100755
--- a/scripts/run-dashboard-index
+++ b/scripts/run-dashboard-index
@@ -4,6 +4,11 @@
 #
 # Called with $1 as the build directory
 
+set -e
+set -u
+set -o pipefail
+set -x
+
 builddir=$(realpath "$1")
 scriptdir="$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
 

