Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D7EC02196
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 14:30:25 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web11.42592.1738852219618308793
 for <yocto-patches@lists.yoctoproject.org>;
 Thu, 06 Feb 2025 06:30:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nQa8zHoC;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: martin.jansa@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dcd3454922so2000232a12.1
        for <yocto-patches@lists.yoctoproject.org>; Thu, 06 Feb 2025 06:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738852218; x=1739457018; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WJJDBg3gVxo/aK+WaqOb/4Nx5GPpVic/6bYWeXYjb7s=;
        b=nQa8zHoCnETOOCL0MrhjAycZzbRHZYOPYoaizVVVf2qaL8fnwUo9JtRiKv0SezO4ZJ
         2D4xFwEUcmX+Da3cb4jUM49CdWhyeWhyoeIGL+HcBSF9PyEqrdOarJ8gyhMYdgYjULp3
         WjDwCOb0AFsPzHg2wEe+f+11kbBqew8UEX0pNVIpugU/gAWEr4uUXeuI88UTJktnmmt3
         h4F48wEv2p6g4DBxvQdBTZP838QTwlThhjrD90+955HxMb1YWcbc97BZbwcLCw1TTg/i
         lLyHNRnitzIC8UYNIfdlnXVr9vIPs30ypWD/55RVpqiIg4/BgAXpfKXzWk4TauaXfle6
         YIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738852218; x=1739457018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJJDBg3gVxo/aK+WaqOb/4Nx5GPpVic/6bYWeXYjb7s=;
        b=APL/1GTnnvH48S5Jpan3soZL+f35nPPlHnH6kNuu8yOZwA4FxjEJvm1s1HQzjYMBtm
         VZ8gpGmZ5TmbXWquP+UwCPs3g03dq88gPu22uYdxrWL7ZjwtMBz+MzyTXwo2/0XSdfwn
         eikxr+Fw1FOWBuwTXpRm9s4JzZuBi/aPQ3ZYkL3ecNEvNkoz4h5tZ1+FHNgaMnLq5dZJ
         t1hSZsr8IvcdMzDafC3gngSZWGMyFFiZmJGjm3qqqNxWjaotTtPn3WR8xBDNRKN6cvgX
         scvoKCFsMYUgJPjjghrrOTFvlazg02dpukDVi3j7DYTqLdeDK1GHpLIZ1jfqKrqKfcph
         qLIg==
X-Gm-Message-State: AOJu0YykSzi5kygcb3tMfTVbakH2uz5H3iFHuZ6nSX8SKo7z17oWHRzT
	hV+tN3yuWY5BDRmbPpUU+2+ITE1Q75FFpdJO3vXiSh0sZzUTpDXCPyYyCw==
X-Gm-Gg: ASbGncuXLCaWWEZsBtmhPVjHuwf2u2Ipx3gCuPlnVtGtP+caJdpQxq1Lt8vZrApOA3x
	q+6WZCbgGvu5Z1GbdBRnYR78saScm+nfeYwqo+P0iCJeCO1p9MZlBgZYjIGzlO8YizMHp9XPwUf
	MV5GwkGTY67NDkzgJZ8OHXyl4bhDpjNlUCh20N0sEK/xZFHtASY7cCu6WCEYuojwcNACyT69nfI
	AZf7wOohF0aklBr77Dmh7cOR2VxXqYsuZOxUc8zeDGqZP1jWi9oUlWvarHVJzz8nX+L2wz2t2Gd
	3vjQnpsI8XxfBS07LA==
X-Google-Smtp-Source: AGHT+IGaxg/jVXs0GV2wk4svzeZWj8vhNxqfUPxodMjYTUQdTf1kio0bCdgJwNjb/hH0jIfW3LYX8A==
X-Received: by 2002:a17:906:7315:b0:ab6:b9c0:1ea2 with SMTP id a640c23a62f3a-ab75e262015mr799046166b.25.1738852217630;
        Thu, 06 Feb 2025 06:30:17 -0800 (PST)
Received: from localhost ([109.238.218.228])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7733399a1sm106658266b.135.2025.02.06.06.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 06:30:17 -0800 (PST)
From: Martin Jansa <martin.jansa@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-tensorflow][master][PATCH] MAINTAINERS.md: fix e-mail address
Date: Thu,  6 Feb 2025 15:30:15 +0100
Message-ID: <20250206143015.17956-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Thu, 06 Feb 2025 14:30:25 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1046

yocto@yoctoproject.org doesn't exist and yocto-patches is probably better than
yocto@lists.yoctoproject.org

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 MAINTAINERS.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS.md b/MAINTAINERS.md
index 09a0cef..e049457 100644
--- a/MAINTAINERS.md
+++ b/MAINTAINERS.md
@@ -20,7 +20,7 @@ When sending patches please take a look at the contribution guide available
 here: https://wiki.yoctoproject.org/wiki/Contribution_Guidelines
 
 example:
-git send-email -1 -M --to yocto@yoctoproject.org  --subject-prefix=meta-tensorflow][PATCH
+git send-email -1 -M --to yocto-patches@lists.yoctoproject.org  --subject-prefix=meta-tensorflow][PATCH
 ```
 
 ### 2. Github
-- 
2.48.1


