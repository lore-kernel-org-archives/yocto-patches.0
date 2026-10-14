Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0778BCC6B2C
	for <webhook@archiver.kernel.org>; Wed, 14 Oct 2026 19:38:20 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22970.1792006689541502811
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 14 Oct 2026 12:38:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bonocM/F;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48c4d99c32bso999189f8f.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 12:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1792006687; x=1792611487; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9C5irXLymanOH4Pgq2vSmUtY54GiLKIkzguTLqqV+R4=;
        b=bonocM/Ff6E7zUygoOc/oVd5BUjTDocxbIoF+IYRnoc/f1LbzWNXQX386kQubSBC3d
         nZHxGM8HbzLDgUMsawPYK5plhj/7ECk8gthKWa3ZQhTSPMLdEb0AxGGPDHwGbxBbzC40
         8EiyJQSUmXro8NogrZFpLBxecVJwIQtIGhdgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792006687; x=1792611487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9C5irXLymanOH4Pgq2vSmUtY54GiLKIkzguTLqqV+R4=;
        b=UMZ3NB7a+U5Yq5yBFND5hezt9OUTG73kbRNPYRrmpM9nSvqxaLKeigiS9zoVrBC1oV
         c0f72EFeA37YFGmQu3eOr3Ddm/vgNBcYp7p5Kh8zrhyZ/LSLlm+5Z1+RYW0C+Z8IpQg8
         jpQ2KKAGljnLU4nY+5ZgSVxYCWANNAknZdgAzFwtSTCel8LSzxULNcS73IMZQxH2a4hN
         irVHR9RRy3hmwSLhMJy1YjGeDgsLR+5my5/GCmC0AWHpuw+K9BuOggJzwdWIhBO7/+gl
         3r3HBgz1dEwri/60z0uEToM8gJ77FhzSCf0RnVmEDMb5JQIH9qSxwoGV6anwwtQs8tpw
         tvdA==
X-Gm-Message-State: AFq9FYIVhqVTqRhdpa4n5gumi1n+vEC7ARxvaLOYy4AhNyHyTZoZcvJc
	XvYLVxezvafFoJZwTqZirpyUJyVj4PvjR2Jn1TjCsbvSRnlTbM6E5+hhb57d1k74yOZ1ZfU33Pd
	hSIMdM4M=
X-Gm-Gg: AYBFou3Z5ys5SzQvZlFvkzqL5/kQetoiHOhz/SKS5g7pMHq82eCWx/hGKDP/MLl4qVr
	WwZXNbyjPSKkg4DDb6c8CZYWhuAxgWFG7Htw761KHuwZmy0As3Tjlk5b24PIRY6Pn4XoeiEYJd4
	Z5sh52b3D6MQWJcBf4yfyeZk2pMTuQct9KJCTYWh1F1URJJJgg0BIGEy08eLIKyerQJT25SIiHw
	RT0d2sZIU5RXhHFADbk92521UiEj6Bzw2yXIqdWTwEpHPLKiI7rHMAa2oc/MINz+0HsBE4iQhLt
	hvCChvBF++bPniOQZnJ15ilA9UG8Hp3dgzTGNmxgaaIAeXLW+AOJtzBP8qYwA9BCWKWyR3j5S66
	HM5pRCY9tGA0JMY/HWopb9CCfgg2wPhvDHl+7fOIgjQsU/ROqS8XIIy9h631h3mmIjasHqAzrlq
	NRTGCXjcSvaO58csjZyxy+rvBiQP8U5HLDG2NJ8SBG0joBotJ9LIX1j/Y2/TlnIHg3XqbJQ0d0X
	P07K7CbSsds9ttHE70+PfTlazDgxW+PnezE4Q==
X-Received: by 2002:a5d:58dc:0:b0:48c:77aa:2f78 with SMTP id ffacd0b85a97d-48dbacecfd8mr24542450f8f.56.1792006685810;
        Wed, 14 Oct 2026 12:38:05 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:2e7f:c3c8:963e:7859])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc6b82sm14207529f8f.51.2026.10.14.12.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 12:38:04 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: seebs@seebs.net,
	mark.hatle@kernel.crashing.org
Subject: [pseudo] [PATCH] pseudo_client: Fix xattr/rename handling with empty paths
Date: Wed, 14 Oct 2026 20:38:03 +0100
Message-ID: <20261014193803.3555726-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 14 Oct 2026 19:38:20 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5027

On Fedora45, we can end up in a situation where path_extra_1 (for xattr/rename ops)
but path is of zero length. The path_extra_1 codepath does not handle this well and
corrupts memory.

The issue is "partial_len = pathlen - 1 - strip_slash" when pathlen is 0 (and
hence strip_slash is also 0). This leads to invalid memory writes and if those
happen to access off the end of a mapped segment, the program segfaults.

Fix the code to handle the pathlen=0 case.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 pseudo_client.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/pseudo_client.c b/pseudo_client.c
index 23d7b0f..002de30 100644
--- a/pseudo_client.c
+++ b/pseudo_client.c
@@ -1789,7 +1789,7 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 	 */
 	if (path_extra_1) {
 		size_t full_len = path_extra_1len + 1 + pathlen - strip_slash;
-		size_t partial_len = pathlen - 1 - strip_slash;
+		size_t partial_len = pathlen - strip_slash;
 		if (path_extra_2) {
 			full_len += path_extra_2len + 1;
 		}
@@ -1804,12 +1804,17 @@ pseudo_client_op(pseudo_op_t op, int access, int fd, int dirfd, const char *path
 				return 0;
 			}
 		}
-		memcpy(alloced_path, path, partial_len);
-		alloced_path[partial_len] = '\0';
-		memcpy(alloced_path + partial_len + 1, path_extra_1, path_extra_1len);
-		alloced_path[partial_len + path_extra_1len + 1] = '\0';
+		if (pathlen) {
+			memcpy(alloced_path, path, partial_len - 1);
+			alloced_path[partial_len - 1] = '\0';
+		} else {
+			alloced_path[0] = '\0';
+			partial_len = 1;
+		}
+		memcpy(alloced_path + partial_len, path_extra_1, path_extra_1len);
+		alloced_path[partial_len + path_extra_1len] = '\0';
 		if (path_extra_2) {
-			memcpy(alloced_path + partial_len + path_extra_1len + 2, path_extra_2, path_extra_2len);
+			memcpy(alloced_path + partial_len + path_extra_1len + 1, path_extra_2, path_extra_2len);
 		}
 		alloced_path[full_len - 1] = '\0';
 		path = alloced_path;

