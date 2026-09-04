Return-Path: <yannik.tannhaeuser@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DEDC79F80
	for <webhook@archiver.kernel.org>; Fri,  4 Sep 2026 16:36:03 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2515.1788539759436669422
 for <yocto-patches@lists.yoctoproject.org>;
 Fri, 04 Sep 2026 09:35:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=AchYuWzj;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: yannik.tannhaeuser@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so8719645e9.3
        for <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788539758; x=1789144558; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GXYb4ff9pJvESl+Kav+CSv+hal8TL5PkFJIpk6ZO354=;
        b=AchYuWzjrzEfJZHBSdDKkH+OAYF14u3z/S0pefVQJPdYHgD4JvnQl1jq+Xakz1AYa5
         VBAyGW/FJunsE98kSS1kZ0QhDbNe12Xbmg/m9Z8/LJuxR9CIqZErcm5Vc4rc/mY69LCF
         +ogxz+XVchw4NUk014YoCZmhQ143WFSiyg1Ms2RKeDa7FwDMxKalbcHNu72J7nfhmKBS
         CWYRMH5va8Vt6L4c1HxpDRtlqJhfrR5RuHAcHTsHz9+54oGADOmnINPI0TeZTk3g87tL
         RAOTTQe5nDhRKjiI8274Pw3QDtbkjXYvbRM1KolOLwk94+qlVJNIvKIgfiHpJNofCmt/
         +gDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788539758; x=1789144558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GXYb4ff9pJvESl+Kav+CSv+hal8TL5PkFJIpk6ZO354=;
        b=Z40u2HoFER1jvRXrWKVP4BBSlvNf8LhZDVpp9hinXlFZNWjX3QYiUB4LpNeWOV/txp
         Jh8RKRF1rQZVknyTK342XTs00eCozREgTdumDWN4bDcw7YK9YFtaK/3/hLItVqwd4GJR
         zmJi1OXxdVzVezbZgxYrhuaLBm6Sp01MwUuip6YqZCpQd+0JcFf+5wfZDvxuXtt7HIi/
         S7MUNQEFQtqQq7slSKgVD2Ov186hR7kDAt8yaGyCcKhY4cvab6qIvwLSm0qRG4IxAL3d
         HAMEs4OwXgYIYmcN8T2FJ4T72pVco9pReQ6QtobUCkXgzQUIAvaZRWTzKa1dRQrt6+Uv
         lxIw==
X-Gm-Message-State: AFuF++nzZfiFxpSgyd7QPbFm/+Fy+3fCBOM1vDDXWDCK/z6UrFGXNhBB
	9K6Tdks8IFvuBq5AgOzEqM2303OL0p6OHdqIJqSg6/SDBLcMbz6QzdiG
X-Gm-Gg: AYBFou3fDunzHDdyn2FekmRCTdnZ4il5YDQmu2BTYvG2XJqDLijA1D33mpeZorafoqg
	5bGn25l8i0+YDxn+jJ9iIQcMKTyWDrNIj60k55GjUzZde4HBjFK97uWOJKktKrUTnJlzK3439fb
	foPunnsTNONZmgEqQTggk2HmKorjpy4O4OW+s+WlUGFwXzxu0Lt+QeFyi5F3eUxpJdXaBpmHJc6
	EjDE4DPh5XqUoeiEm8COs1MNTeDg3M+R9Z5aN7LUjSLqzV0SS6SqGOCk2zFeA2YmQ3RbPEYYnMB
	o8C84lje6Gid1R+phjc/1XcMWa1lOXp8WhB84MZs2kYvAiZFitVX265Q/vc3aJzjcxqHxVpN4EP
	U86qpuvxr7M7BquflfM5a1zE7oEO5P/XnXpcHXcSYgdxAFKbMP3A7hqepASfgbcBJfpPmbjZqQj
	OBk7qKSc9T8sOWEmPbGrmmVQHbSx5SPCNNsY5cYlLWWR9F8E8Gs8HoPSLEKO24X2MyhBZh9QHO9
	7O4REOMk+NTjAew51UkyZkrXqZwcrxktn/Y46V4hV3VFAUZm5lAd4z01sbtOJaY2iDRQfz7OEd4
	SZU=
X-Received: by 2002:a05:600c:3ba5:b0:49c:dada:f581 with SMTP id 5b1f17b1804b1-49cf7f39c8bmr91829345e9.0.1788539756768;
        Fri, 04 Sep 2026 09:35:56 -0700 (PDT)
Received: from ERL0724PF3HPJ22.fritz.box (p200300f847017a009ce9fbcb9cba4fab.dip0.t-ipconnect.de. [2003:f8:4701:7a00:9ce9:fbcb:9cba:4fab])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbe5b252sm51378365e9.3.2026.09.04.09.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:35:56 -0700 (PDT)
From: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
To: joe.macdonald@siemens.com
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-selinux][master][PATCH] package-labeling: Add postinst command for labeling
Date: Fri,  4 Sep 2026 18:31:03 +0200
Message-ID: <20260904163548.631624-1-yannik.tannhaeuser@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2064468.1787219519532860987@lists.yoctoproject.org>
References: <2064468.1787219519532860987@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Fri, 04 Sep 2026 16:36:03 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/4733

Hi Joe MacDonald,
 
please let me know if you have any suggestions for improving the commit.
Or if you are not interested in taking this commit.
 
Thanks,
Yannik

