Return-Path: <yannik.tannhaeuser@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57720CCF2E3
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 11:41:12 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.32311.1792410065482046055
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 19 Oct 2026 04:41:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=aHtDy1Eg;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: yannik.tannhaeuser@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48dfdd0678dso1314150f8f.0
        for <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 04:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792410064; x=1793014864; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GfUh64d7pVC0NXmE5xUp4fS8BjbWFZ4ADTgJ9wxCl8Q=;
        b=aHtDy1Eg9smb6HALyyt5Gvxmvo8LQ8sH8SH8QEyRqeYVqGcgbO6vh40vXUNEF9La8B
         O3OFZQPS9duqph26CCtRjOThzvBMmkvmjmuBLXg2UinXQJDhvvuGz+5oEwjeK97LH66v
         oRVNN2d78ZzM3FaIxl6jeaCCxzTP7CIhR0paTye1rsnmgfg6CuGnigo5izDsyfH5d66Q
         mRUzwUi7A/cabUuczMpQQNsUMw89utcFeusudaCWTugbxMk3d8G46ijMqo2I66JIlvFH
         RwJtNNVZkM6mQcUKYrzyXkNyBoSdSVJVQVi8fGeU9kj1gNkIvzJXCcjAsXbQw7MSR/DP
         r0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792410064; x=1793014864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GfUh64d7pVC0NXmE5xUp4fS8BjbWFZ4ADTgJ9wxCl8Q=;
        b=ZTN3oWYzxcrvmZUHea/+dRqYS6UaK/Z47OqoXxwbx9BghXhiANcH/691mkcaMG3PND
         vcKop6luTTUF7RWas2J+OUCcauF/Bvu4gOgYcUW0YM9a1tw2sm4ygMpQS2TcWp5c7tEr
         3IRGFhB1oAto2UhH+yqnLmpmSmOkl73yhap1L0oZchRVDz9J7iQJZDeynVj7DgZHiwhL
         7l39DeEbiROQCIMhgtZEUBeHGyWcZYHadniORxfUYHpSZtuUmvbDdrX0hcoOdJBPf7Rv
         Xwubmd3v6IM+Zoz6lenyxxmXV8SwK9Jr3mMMcpSZgTxkT3UR1BYOxpqQjgvDxVOslKwV
         XZgw==
X-Gm-Message-State: AFq9FYIqYYG1q8VdK8vQP//PD3lHlPQfP4XCh5OUGrYRnjmERdforvMw
	+3xJe6cSOfVXKQSQltIQkPLgER8oBUJcxvyFfdVjOuHFyxOWBHIpwdwGzeT+vQ==
X-Gm-Gg: AYBFou0z2AD2xWSjN4wGh3kn+eGOwkC8TWNgUY4vCyJBM+t1YcQw9DIsh6jra/B1x+p
	4sS3755uE3LxcKQ+pUg2+c4g0INe6qgHDzqcXAv1qT4wEBzT0fv0p0MC9mVoFwbRV+MZBauyZ37
	JbVAl5oZt7r1q2U8Bhq9pz42s2R7R/SGdqRf5mBqIzkHi3Ne4jcbCMs4Atc/FF7GiO8LAU1dqvk
	dpXgOA36Oxiun7Bw+IcZ1Lm114S2YzAWxrnyunmFXUr08wHMslCSnK7no3Icv1rd25LW2GX/Dbt
	C0NQI8tPfMDUC0lOOaNdhxnIQA/J/BKMPnHpBKRHqFvdUgM0oWQZb7Clnocsgm/uqKZpd2sfX8e
	NEeHDWTqAyRDWSXr3vGouWs0nGlLytMPd8MtdbNJ2jDqwd5zkNCoqH7oArXbUwKZWqfzG/YcK2e
	5H/dWV/gOaVswSkZtYHcmF7OS661xljmK+WQBEEs7aBGobePk7g/s7hCFoC98wCQOwbpB6RRbwC
	lbYUARcyOf3U8dY
X-Received: by 2002:a5d:64cd:0:b0:48b:f92:1f75 with SMTP id ffacd0b85a97d-48e07fb9321mr13803496f8f.48.1792410063208;
        Mon, 19 Oct 2026 04:41:03 -0700 (PDT)
Received: from ERL0724PF3HPJ22.. ([2a01:599:a23:f6bd:6dd:608f:ba62:dd8f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5942sm32096825f8f.16.2026.10.19.04.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 04:41:02 -0700 (PDT)
From: Yannik Tannhaeuser <yannik.tannhaeuser@gmail.com>
To: yi.zhao@windriver.com
Cc: yocto-patches@lists.yoctoproject.org
Subject: Re: [meta-selinux][master][PATCH] libselinux: Reduce memory needed in libselinux
Date: Mon, 19 Oct 2026 13:40:59 +0200
Message-ID: <20261019114059.813764-1-yannik.tannhaeuser@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807133123.424089-1-yannik.tannhaeuser@gmail.com>
References: <20260807133123.424089-1-yannik.tannhaeuser@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 19 Oct 2026 11:41:12 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/5096

Hi Yi Zhao,
 
please let me know if you have any suggestions for improving the commit.
 
Thanks,
Yannik

