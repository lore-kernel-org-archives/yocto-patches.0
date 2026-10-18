Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89536CCF2C4
	for <webhook@archiver.kernel.org>; Sun, 18 Oct 2026 01:50:16 +0000 (UTC)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7863.1792288206791374016
 for <yocto-patches@lists.yoctoproject.org>;
 Sat, 17 Oct 2026 18:50:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=UccKSKuh;
 spf=pass (domain: gmail.com, ip: 209.85.214.170, mailfrom: ticotimo@gmail.com)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e5d0ee1951so6834275ad.0
        for <yocto-patches@lists.yoctoproject.org>; Sat, 17 Oct 2026 18:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792288206; x=1792893006; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oc/DnWUlrLl0MmxFE64g5XLO5o0d20SY8JI/vZlBoRU=;
        b=UccKSKuhD0QRbwAXy5ztjk/8LCXiTbcnBJnalpztgxlTdqcOCNb0aUD37OLoYUwTCH
         tpK8VA9trPkvGf3xMm8MMteIf4WGq8HcEOvPU99ud1ZtskhxBjtSqIEyEODv+qx1cRWV
         UI6YWf/lV3hpfEXaCkS97O9nmythTvnMYwbsta36L/NMhb7sWDtnYhSDc/mFLWMuPw+L
         CASZfc07HnU4TzGrW7YB8mteTnS5fDQUVFCDOdDMj96Nw6Ign2zauuhC41JFSxLAfPIi
         bQdc+jidrE1BBRhNVuCHY868uela2OcBxVOUWlpsl9oKlKIdnUUrrRM6kXT3hzxzIOj5
         N8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792288206; x=1792893006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oc/DnWUlrLl0MmxFE64g5XLO5o0d20SY8JI/vZlBoRU=;
        b=kHNRBv9aqjIpRGVRcYbnDAw6Sz27eXl/mapz7IorXKBd1kzUCw176pAuKQKal2PdUc
         Bi8nXModZNnOLSuENFnTmL6U5Xy9xajq1cwCj/58/jpmlVBy4kRi8FLP2JvxqVWI3sPw
         gR7j8bJc0etxTgBHjPpkCKxAMxFaXax9SuAg2jhzi6PzPzFm6JuOVS+cxadcvcW+4ObF
         ziKoNIu2IC3W06IyYIXe4uiTCpbZq0kpmuFxTQIiqUGJU2BWTrGvaUhCWcIJ4ESTG0io
         QTmESW5kWcNFkqkqCFmzuuKwj6VgK5OfmP02//lXW2DUF8CpNfS6Zww24ZgCoLBiQWIA
         HbfQ==
X-Gm-Message-State: AFq9FYLS1D/9BAUX0CdeeAcioQOd9a6AXz7OjqjsUrqYJ+IffhC0aZOz
	TKIVFlewiVQCCHUaxgAJV4OkDnfZodWB9WG0oVk+dvTaZfomwl9G1xpZ9FWO9w==
X-Gm-Gg: AYBFou3ghcJhMfYe4ijSv/ckXQf8VJPjczSU3sGZVf9500T3WYjoPB/EmMX0uuNiOCY
	tQM5AYyCl2YgRW/2IWob+00WsOFN0RMU/AFdEFSSMrpy5aDNeXsY/koa368cpAJf5Mnumvo0M8f
	VXaozFqqwSOjVCBFBSIYfh/yOiQnQj186HVlhLyCJsG9W4vzzgUnlYRSl87alG5Ul5Vefm4ukaL
	mQVhfNpKyk0xZzi7r3k0QrAnt6zpZU613A66IWFj08K03k//UrqdgWWPmAOu60OSo8JNQftcAlX
	WAU3chlemE06xcVgWBxRkbhz5+FqaQyMiyrX/89Rkdf0M8NFWAzUjqwTaK0j7RDG4fNSSKJaup8
	eD5l0mu/obAddew1RKfVt56av7vWRuFnDDb2vSPKaIX0cUGNRglCd8iN3dpW8tqe6zOiAJr9JDH
	p1qPcwKNoNFu0zHdbQdiJJrsM2NC/bjFfXw+B/SiA1g1CLQUC4GWp767ALYllyu4sr6dWZCn6uN
	LDGPo0jko4LOXBNDlF4PEoulz/rG3Y=
X-Received: by 2002:a17:902:d4c9:b0:2e9:66c4:1717 with SMTP id d9443c01a7336-2e9a735f740mr33219875ad.61.1792288206157;
        Sat, 17 Oct 2026 18:50:06 -0700 (PDT)
Received: from localhost.localdomain ([69.9.132.159])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e87994bsm25005515ad.60.2026.10.17.18.50.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 17 Oct 2026 18:50:05 -0700 (PDT)
From: Tim Orling <ticotimo@gmail.com>
X-Google-Original-From: Tim Orling <tim.orling@konsulko.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Tim Orling <tim.orling@konsulko.com>
Subject: [error-report-web][PATCH 2/3] Update base images to Python 3.12 and MySQL 8.4.
Date: Sat, 17 Oct 2026 18:47:45 -0700
Message-ID: <20261018014924.73070-5-tim.orling@konsulko.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018014924.73070-1-tim.orling@konsulko.com>
References: <20261018014924.73070-1-tim.orling@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Sun, 18 Oct 2026 01:50:16 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5052

Python 3.10 is end of life in October 2026, MySQL 8.0 was in April
2026. Test against the same MySQL as compose. Use ENV key=value, which
docker build no longer warns about.

AI-Generated: Claude Opus 5.5
Signed-off-by: Tim Orling <tim.orling@konsulko.com>
---
 Dockerfile          | 6 +++---
 docker-compose.yaml | 2 +-
 docker/run-tests.sh | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Dockerfile b/Dockerfile
index 080befc..94d55a6 100644
--- a/Dockerfile
+++ b/Dockerfile
@@ -1,9 +1,9 @@
 # Use an official Python runtime as a parent image
-FROM python:3.10
+FROM python:3.12
 
 # Set environment variables
-ENV PYTHONDONTWRITEBYTECODE 1
-ENV PYTHONUNBUFFERED 1
+ENV PYTHONDONTWRITEBYTECODE=1
+ENV PYTHONUNBUFFERED=1
 
 # Set the working directory
 WORKDIR /app
diff --git a/docker-compose.yaml b/docker-compose.yaml
index 5ef4913..0291ff5 100644
--- a/docker-compose.yaml
+++ b/docker-compose.yaml
@@ -1,7 +1,7 @@
 version: '3'
 services:
   db:
-    image: mysql:8.0.36
+    image: mysql:8.4
     container_name: error_report_web_db
     restart: always
     volumes:
diff --git a/docker/run-tests.sh b/docker/run-tests.sh
index 54aaa8b..2eafd98 100755
--- a/docker/run-tests.sh
+++ b/docker/run-tests.sh
@@ -17,7 +17,7 @@ trap 'docker rm -f $DB >/dev/null; docker network rm $NET >/dev/null' EXIT
 # Root so Django can create the test database; testingpw isn't a secret.
 docker run -d --name $DB --network $NET --network-alias db \
     -e MYSQL_ROOT_PASSWORD=testingpw -e MYSQL_DATABASE=errorreport \
-    mysql:8.0.36 >/dev/null
+    mysql:8.4 >/dev/null
 until docker exec $DB mysql -h127.0.0.1 -uroot -ptestingpw -e 'SELECT 1' >/dev/null 2>&1; do
     if [ "$(docker inspect -f '{{.State.Running}}' $DB)" != true ]; then
         docker logs $DB | tail -5; exit 1
-- 
2.56.0


