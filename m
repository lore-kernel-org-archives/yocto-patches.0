Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C467CA5FA1
	for <webhook@archiver.kernel.org>; Tue, 29 Sep 2026 08:13:15 +0000 (UTC)
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3083.1790669587762996446
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 29 Sep 2026 01:13:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=oViKj9GI;
 spf=pass (domain: gmail.com, ip: 74.125.225.140, mailfrom: martin.jansa@gmail.com)
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a006bb267eso8845745e9.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 29 Sep 2026 01:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790669586; x=1791274386; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wNesiosYDWLzrdm+4vZn1MTpPn4HVUXzC8KRiCF+m4I=;
        b=oViKj9GI+6jNvC4GdIXA4CrQesjEOUJzic+JhP1wN1kZB8R6o5RJypVLJrwq4kzCIt
         8muoT4lkQLB4FwvSnpPEtn1TdDTTSZEUK+ikbwdxg3lZfVcCSW2Z3Sj8dKGjfi3j1pBN
         yAJ7wnMmwZd+iO0lI9IbWlbJ3ALkEwuGdumBo6y9t5/atxz4rlk/e1oPMUnLyP1zfmHM
         /+9P7kIvEhwXpeo3fbSeXv+1/TzNWGBsjntzaqRwdO0XRhgCwDQRVvqtu/0JE/SsJY9j
         h9qYXypEWkXy4wht5UdFwdk2RvTBVJfNnvq8TiZtFAqdSbRhdBT0kiED8yiibfIhHvNr
         5aIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790669586; x=1791274386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wNesiosYDWLzrdm+4vZn1MTpPn4HVUXzC8KRiCF+m4I=;
        b=Vhv1O8mV6UjlYV+ZP+Y4WXMAY0h6FASdoGvft9U7UZvuKu/G+WPzG20npOHUSf7dmL
         k4ZTJVVGjfKewj0zwBBTFKTXGaSMLZmtNrpld07iPfIpPdvnFpXY5Ot0Or9KrLqKgA08
         aIkj24eKPSDlqvTqT0I3LHvOctznU6D0NpT5a6e5CZMEoy3AXJsHoVNW25t2AvahsslV
         qBL/+9NUE41kzsUyBqtarbbucvbt/zBKRuupNsVqP8iFHQU9MTsxPRsldj/WbWKN+zSk
         tngyN0/B8Cbd+soLZvXmmEDoLU9CAZzTQJjgq15FKQ23b517eoSdwe7J3NOoSkwUSFBw
         sLIA==
X-Gm-Message-State: AFuF++mdzAIGwHfA7ukfu8iDZF2o0fxoMKzXFzOwy3HrIM5T41ZyXKGQ
	eQw/ExpxTFWpJ5Z05K76wf13APKxOOBJMfA/VA5tkdR/aI6qdAP+xuMswW9k+A==
X-Gm-Gg: AYBFou2u3OSCF4hY9KvlU/ekkKlmAuCqYYy+NQKFxxHxfPA/1m6afrm91tFlnzCSz1W
	lMTE7V/UZZhrx9drDmIsMK0OQteN7yo12AOQwstUu6zfAHJOIRzoYmeU3YgPxR1taMpMyzba4bg
	GQHmz9o0IkBiQ83nwHbOaOIl0GBdQQE3J05jGhMZYkY14fgKeCiLGIpwTHt6CjyCC+qNw6kxcd7
	bm+vy+S4Pqrh2zcBla7HXjqnt9I7pWyl77nsSyJ/AassQw6L1LUhFBFxjk+r6/eyINwfg1oUC63
	n6n6LzKm0/YNwyA6hzLatcVGN3LhacY+JJYek0lVJrnWYgZJRUMnc/dGEGi4EABPygxUgnZ6m8W
	o6ywnCrG9ykaJDB+/fU6n7zgfhcJQzY7V1b85zyytpIDjhSySWijz6ASUkKA4YROcAsTGjeCcxB
	MsR6/qVtFqQfTeFFX/StcVJ1KtdItrniPjK9R7qIMtMKwzHHuZ35uHAeTBpbPNz22w59CCu23eY
	w4xncMudOE9uczOE7kYzBDpodKkoNMFMDWadEPegkB6b6xp9bwpois=
X-Received: by 2002:a05:600c:4f45:b0:49f:fed0:fc47 with SMTP id 5b1f17b1804b1-49ffed0fe54mr142252855e9.1.1790669585834;
        Tue, 29 Sep 2026 01:13:05 -0700 (PDT)
Received: from localhost ([109.238.212.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af4e8a332sm2491972f8f.0.2026.09.29.01.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:13:05 -0700 (PDT)
From: martin.jansa@gmail.com
To: yocto-patches@lists.yoctoproject.org
Cc: Martin Jansa <martin.jansa@gmail.com>
Subject: [meta-security][PATCH] layer.conf: Update to blacksail release
Date: Tue, 29 Sep 2026 10:12:59 +0200
Message-ID: <20260929081259.3856073-1-martin.jansa@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 29 Sep 2026 08:13:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4964

From: Martin Jansa <martin.jansa@gmail.com>

Changed in:
https://git.openembedded.org/openembedded-core/commit/?h=blacksail&id=37623ffbdd34a5c6b3e12ee33195f8e82343f198

Signed-off-by: Martin Jansa <martin.jansa@gmail.com>
---
 conf/layer.conf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/conf/layer.conf b/conf/layer.conf
index f0d8bba..af9b105 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -9,7 +9,7 @@ BBFILE_COLLECTIONS += "security"
 BBFILE_PATTERN_security = "^${LAYERDIR}/"
 BBFILE_PRIORITY_security = "8"
 
-LAYERSERIES_COMPAT_security = "wrynose"
+LAYERSERIES_COMPAT_security = "blacksail"
 
 LAYERDEPENDS_security = "core openembedded-layer"
 

