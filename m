Return-Path: <raj.khem@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6683C282EC
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 21:16:15 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
 by mx.groups.io with SMTP id smtpd.web10.2563.1742246167176769755
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 17 Mar 2025 14:16:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=fUuvyfP2;
 spf=pass (domain: gmail.com, ip: 209.85.214.181, mailfrom: raj.khem@gmail.com)
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-226185948ffso28154485ad.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 17 Mar 2025 14:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742246166; x=1742850966; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fqYMeUFFtffah7h1avfM8JHe8Gu0S4L6Js8q6x+D7Y4=;
        b=fUuvyfP2uivdMQNbJOMmXZIIWOJblngCq/kim4cHSN+jvcYmmvAccLAlUk+rS1I+IE
         EbJP65lz41wxADAs2QC9a44cF3rWjkS1PISiLG9LtQregztlEEIEaynupht1xmS47zKs
         tCr6KCSYPNcs6yEd78oDTf4jYpWJ+QBcRR8lGgxElKRzy28b0lp2M9/BsfhAoxSZvh/z
         Jq3N93O27SdFZTSC2OA6raO25xQX1dbV97gHgRDEbAkCD9c7hb/EH+RrBXfgULftN8Ko
         B3fa/4yo6XKzGMH2J4QdLyLgCufJYeL8hhnyXLAFLcXA5mc85IE3eVSX0IUsAzuX76JK
         xDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742246166; x=1742850966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqYMeUFFtffah7h1avfM8JHe8Gu0S4L6Js8q6x+D7Y4=;
        b=wjOtycwuGk52GNP3xHWGa7OGYDlgqacC4lcTORfsslCw2w56pa4LKiUaw97OKnkWks
         CzQZm20Ut/bu4cs1bRXY8K92b5dTuo4ZzvMD10t+KgqvHXf4ykIkFLLTpTFVPgw43zy9
         DR+f8EQ3xQodNu5Y2KYJsh8O+4/m90rUnqJGBcKqKuCpXQdxxdry0CUMfufagtW49ljl
         eGEXNk3V+6WgsXpYdHd3zSc5HjNCX8tRIGdPv8G/h8CjhqDRj444H11dR/T7ir5iVdii
         c18HjQBiD4qSExIcuz6j83ZLWl343PYzP7Inc4by2Pkh6Uwy4TfS7ykZZ01eeANt8Yiv
         iwdw==
X-Gm-Message-State: AOJu0YwJCwSPXuwaf87TvugMTX1b/lPMpNVboQ9TA64dUetbHfgh904e
	vjMy1jnFx+weTc+yMjgV1eky74PLIUDc2K94KbVUA/GEdX8lp/0nAqMDo7HE
X-Gm-Gg: ASbGncucATsDghfPTbWKHbKoUg2/mihdN6A9hZ3nt0LH6Voi2WA5Guh3gS7A3azauan
	L5Zk6FWMcfrCtT1JFCJvDtFFIKXF1wvyYFFwC/eblfq+RfxczgxwAHmIbM5PXsHhI3hgsHBn1JL
	fync6coG/hxI3qM92OAnFeiG9zFGZe1H5FNwCJo7IyPH0d8ZZr99TWbJcl7j0Iez1QfH1xfqd2M
	P9ytwMtTnFfCvkWjrjAiOrUcJWFgh9bkLpNbw3edeYYZ2NyCm8mFpywWaHvjsjJ+GAzU3J4l/3v
	0xHGdK0A3MJSQcswGEyroF8bD5IraZJqnD4f
X-Google-Smtp-Source: AGHT+IExNAArI4sL9xrgPvl0bLjktF3qZ3v2BTg9Kf8injqDToLvKTiEuf9IIlU+KHD1o63oQ27spA==
X-Received: by 2002:a05:6a00:1829:b0:736:a540:c9ad with SMTP id d2e1a72fcca58-737572d542bmr1329449b3a.20.1742246166165;
        Mon, 17 Mar 2025 14:16:06 -0700 (PDT)
Received: from apollo.localdomain ([2601:646:8201:fd20::6874])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b1103sm8100010b3a.167.2025.03.17.14.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 14:16:05 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Cc: Khem Raj <raj.khem@gmail.com>
Subject: [libmatchbox][PATCH] Define correct prototype for hash_empty()
Date: Mon, 17 Mar 2025 14:16:03 -0700
Message-ID: <20250317211603.1134031-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 17 Mar 2025 21:16:15 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/1211

GCC-15 follows C23 standard which does not allow function
declarations without parameters and types

Fixes

../../git/libmb/hash.c:76:6: error: conflicting types for 'hash_empty'; have 'void(struct hash *)'

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 libmb/hash.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmb/hash.h b/libmb/hash.h
index 86f18bf..43827b2 100644
--- a/libmb/hash.h
+++ b/libmb/hash.h
@@ -38,5 +38,5 @@ struct hash* hash_new(int size);
 unsigned int hashfunc(struct hash *h, char *s);
 struct nlist *hash_lookup(struct hash *h, char *s);
 struct nlist *hash_add(struct hash *h, char *key, char *val);
-void hash_empty();
+void hash_empty(struct hash *h);
 void hash_destroy(struct hash *h);

