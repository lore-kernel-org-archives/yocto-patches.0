Return-Path: <vince@underview.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A25CA0EE4
	for <webhook@archiver.kernel.org>; Sat, 23 Aug 2025 19:19:05 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
 by mx.groups.io with SMTP id smtpd.web10.3245.1755976741830934731
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 23 Aug 2025 12:19:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@underview.tech header.s=google header.b=gy2ROFSH;
 spf=pass (domain: underview.tech, ip: 209.85.219.53, mailfrom: vince@underview.tech)
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-70ba7aa131fso38856926d6.2
        for <yocto-patches@lists.yoctoproject.org>; Sat, 23 Aug 2025 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=underview.tech; s=google; t=1755976740; x=1756581540; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oJvJvesU3+EVRnT5NshwQiqeZ8+Y26frPXmDXW2Xsr4=;
        b=gy2ROFSHLA62UDTyQas69ekqTObBjQSPzrQS0THdrypb/tI7Wtn10oA6UMQjVlD1Y7
         GGaMqT5MduZVU/3i2fmLkVED5m+t6IiYqLaNJl3TTcPqp7DME79mK8i+qOr3G+zh6ZRs
         AVPjqd4HBkoyvUGq5sYbJdR29/chf+WaQ16yk3N6L1LM1n/mgC2DxVH9OeJjxUvFLmey
         UpqVcpWVUQJmhB7ynLknLk14cyHlCCwQzrgDZc0QolAzbh7yKRhPOFuLSGgwhoKWmXMy
         nhhhJ81SIUbQwcJiXauRdohj7CtIYQ4pZbLZMy5AbLzAB0SjjYLHDHIdLqD3YhxcI7xs
         6tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755976740; x=1756581540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJvJvesU3+EVRnT5NshwQiqeZ8+Y26frPXmDXW2Xsr4=;
        b=OEbypGMYDhXeaLY1g2N48WK7JU1Vv5bhl+piaxTKydF6PVdIo6/ZXVIk9dInX+GcLW
         AHVLkZZ4YB9IqSR8sN3eBVrs0Uzx+GG/5Tg4IsGhVcpdCjTyBMGuy+C2YX0WjXwkgOfm
         zbAGYefiNUMuseWikJ6l4sW+7e16Hysw5BUiZPeiWml/C5hlwFScQ5BLcxpUKTbFFCZp
         Pj2Gu/Jg2QdFb9RnPpY5imrQi3NpYnZXXJLyjuowwRs4XU6gukxFXaNF6Ynauym7Kzvo
         7g99os/feyq/OLJZl2nHQ8oaLmz9mGAtfY0fyFQ+ed8REpjDCPANirBg0c4SAd+4XXIB
         vMVQ==
X-Gm-Message-State: AOJu0Yzqc+80dxXXfN6NsGmPw6cnivjHzaoKsGZJ91lna7/cEeJRHlS0
	RMhMPL7gq81j2YuZD+aHu5hOF+3Zy4NJEoxxU2Jat/d3LTkZ5tZjaNGcN8YbDnOuggwJh/cjssY
	Muawh
X-Gm-Gg: ASbGncsMr1qCxDZ8d7fAg6ADP46qX+GOgHKA+3tKZLSsJI+MvDNukNVqfX5ntt9owyO
	bEMB+p0639elgMsSuP2ei8aOMyqKKAV6eGfDQrfHY4yUpWgTth4rnc7ttNkR61JzcdZkZwIhzRp
	eRrnyHO+lGIDFMlzTJTteYRoxUN5UVmWoruGWld4ZJyx22Y7D/ZWkzJ44dcdK/5jMrcQbIOfb7H
	E0udxqEXQ6NFePlUOxO/YdGVbwNQoOSOnfKq71KYKpNWg4owCltcYRP0eqXKphG8A9o9AW+mgCo
	Aq55b4sy7cage/a9dN2EcyrxNNy1Il+Q3OwHZMQh3HU4hgjQ11nCXqWiQjlt+Nfl4A0cVQfzIxA
	fw0zCCLpIZO8=
X-Google-Smtp-Source: AGHT+IFG2lYuS3Hai1gllutuXern5Mon11TQmN67M0uSP3jJm+fe/ukBhoZcBsIAIelJjEwVJoYUiw==
X-Received: by 2002:a05:6214:5283:b0:70d:ae3c:b712 with SMTP id 6a1803df08f44-70dae3cba60mr23153896d6.26.1755976740477;
        Sat, 23 Aug 2025 12:19:00 -0700 (PDT)
Received: from vince-server.. ([2601:406:4d01:1820::6d26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da714727csm17583436d6.13.2025.08.23.12.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 12:19:00 -0700 (PDT)
From: Vincent Davis Jr <vince@underview.tech>
To: yocto-patches@lists.yoctoproject.org
Cc: Vincent Davis Jr <vince@underview.tech>
Subject: [meta-selinux][PATCH v2 1/2] libselinux-python: fix No module named pip
Date: Sat, 23 Aug 2025 15:18:56 -0400
Message-ID: <20250823191857.602063-1-vince@underview.tech>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sat, 23 Aug 2025 19:19:05 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2081

When running the do install task run
into No modules named pip.

Add python3-pip-native to DEPENDS
so that pip it available.

Signed-off-by: Vincent Davis Jr <vince@underview.tech>
---
 recipes-security/selinux/libselinux-python_3.9.bb | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-security/selinux/libselinux-python_3.9.bb b/recipes-security/selinux/libselinux-python_3.9.bb
index 8431ca1..a4de036 100644
--- a/recipes-security/selinux/libselinux-python_3.9.bb
+++ b/recipes-security/selinux/libselinux-python_3.9.bb
@@ -19,7 +19,7 @@ SRC_URI += "\
 
 S = "${UNPACKDIR}/${BP}/libselinux"
 
-DEPENDS = "libsepol libpcre2 swig-native python3-setuptools-scm-native"
+DEPENDS = "libsepol libpcre2 swig-native python3-setuptools-scm-native python3-pip-native"
 DEPENDS:append:libc-musl = " fts"
 
 RDEPENDS:${PN} = "libselinux python3-core python3-shell"
-- 
2.43.0


