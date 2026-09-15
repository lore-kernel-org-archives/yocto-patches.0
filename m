Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4007C88E77
	for <webhook@archiver.kernel.org>; Tue, 15 Sep 2026 20:29:57 +0000 (UTC)
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6371.1789504190755979709
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 15 Sep 2026 13:29:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YeqaB/0E;
 spf=pass (domain: linuxfoundation.org, ip: 74.125.225.76, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so66001f8f.3
        for <yocto-patches@lists.yoctoproject.org>; Tue, 15 Sep 2026 13:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1789504189; x=1790108989; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bdCjxiruzqb0Y09DXlkPOEzWlKUKCYDs9bwrX+6KVuQ=;
        b=YeqaB/0EF4AGkB3EYDMeyKBTOhaIbgfuqu+NHJNg35k4fGjEVSU1vTScyD7h99kkRM
         HoeRqjoSY5oH/zkX+LLg1h6bSOMusEmhx3bpnZ7ak07GB/b7PkOpqi9Go/PlfqK7aT+7
         W7hxP3glo0QDZFPh14sn25+65nKYSB9zq0B7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789504189; x=1790108989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bdCjxiruzqb0Y09DXlkPOEzWlKUKCYDs9bwrX+6KVuQ=;
        b=2cE/0/FGR1iCMTcbjN1k/GzxQXx28CdIERa9v0SCd6VGryTBa1hiRitS15gmRwSuFK
         OKxdhp5c5h+7lwCUFpuyf9d4aL0AGILt3iEuElvpIaN8SkSuI2SWeeofxgCZNQ+deAMu
         V+s15B/GLPw5zPdWYUEFjfANI1ZG08zziBggm5ZRkhsY5qYtr2hbQcZzM7VjP9Fk06LZ
         dqbfJcIGL1U90x4A5G6MbS3WqSeq54Qg045zylrJ40/f+kvKP3WyqT85SqOdeeYQcV7Z
         RzEooiYnCGGq5F295JAG9GSa3hiKQUCjqUaW5k+Q9e7zW5gqFVL2aQyr+8CAKqbqW1So
         Tl6w==
X-Gm-Message-State: AFuF++l0w/Wld1mPyxqLlojYNvqVfX3nps+s09SFUJOZpryLR4qtLtr8
	Ls2gpjRUkWhyUjmijBf5LDiTNhUcSVED9UiUxJzK6WUoibXJ/xhbTC+8RMtsH3Gjh95OTdHOcpi
	+GLfReOY=
X-Gm-Gg: AYBFou27Lj3yuFPDzv4XzkuQ3Ydx+cj0VxfANn0PD501TqDw7y0Nu1Bq5ziZOCGuv+m
	wDqj/uHTX1+is4GGDnJUvrnvd+RIwZb8kXWUx+xEE3cN+dfgC7srAROij39Z77aiRK+pkCbIOHS
	1NahqZl3k8EL3bEsVWXXScchzT/vN9WmT9sckD9PVCKKo8r7LwZoaYXAXTk2BHXZcrkH9NMBcbF
	Jcg8BXF87hHY8uVstghYndrA3yqjxwllxnj1uDg5y0INmQag59s6O/0hWZ5+iRDW1nG6RsJaKmG
	2i9SFdTgaL1u+YaA3J7oYTA5CR1eqwtO4SyLyVysH2YUKraFXmqw4AWWUzZJcRyoZGQLICX8GL4
	qmwmrBbrBCT7gGtIDmlWk8wlQfjejReSDMXLIwTFKTm3nWc8e9xPwThKwON8SSlPWMq32w5JuK4
	S+Rk2wiZLiDSo3eu0rPLU/uLTHo2Aa0tJCHlMve07cftGOL+T9ddgQosFitJJJLh7OXQyN6iQtF
	B6A1vv6BrarY+W48wjNgt1gVMw=
X-Received: by 2002:a05:6000:3110:b0:487:952:bb75 with SMTP id ffacd0b85a97d-4870cf0a036mr127659f8f.7.1789504188925;
        Tue, 15 Sep 2026 13:29:48 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8a6f:78a6:4575:a18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf1f6cfsm1524734f8f.13.2026.09.15.13.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 13:29:47 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: yocto-patches@lists.yoctoproject.org
Cc: Richard Elberger <elberger@amazon.com>
Subject: [yocto-autobuilder-helper] [PATCH] config.json: Disable meta-aws for now
Date: Tue, 15 Sep 2026 21:29:46 +0100
Message-ID: <20260915202946.3117931-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 15 Sep 2026 20:29:57 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4851

Until the current failures are addressed, stop testing this. Richard
will let us know when it can be re-enabled.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 config.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/config.json b/config.json
index b887900..22fc16d 100644
--- a/config.json
+++ b/config.json
@@ -688,7 +688,7 @@
                 "BBTARGETS": "agl-image-core-autobuilder"
             }
         },
-        "meta-aws" : {
+        "_meta-aws" : {
             "NEEDREPOS" : ["bitbake", "meta-openembedded", "meta-aws"],
             "ADDLAYER" : [
                 "${BUILDDIR}/../meta-openembedded/meta-oe",

