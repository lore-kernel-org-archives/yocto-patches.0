Return-Path: <twoerner@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3446DE6FE31
	for <webhook@archiver.kernel.org>; Tue, 23 Dec 2025 21:03:36 +0000 (UTC)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.108663.1766523808618981745
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 23 Dec 2025 13:03:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=mMBpQC2F;
 spf=pass (domain: gmail.com, ip: 209.85.219.44, mailfrom: twoerner@gmail.com)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-88fcc71dbf4so15279166d6.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 23 Dec 2025 13:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766523807; x=1767128607; darn=lists.yoctoproject.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=butJpHnqQ90SHoGGD42cin4PuKq/RXOJvTfZuOfcYHA=;
        b=mMBpQC2F9c3HsljNeOwgEMGMTdU+lnuEYR0pSQarFVOUPRIbFxRtXRHSoeYtdGjyPZ
         Ey6yPe7QPIdPLcGYCI0pLHp/JT5qsX1N21gOZ2jxi2dJoaKwAKVQ5cHfKUm6hspe4g+k
         QjKj4KWDaMm0Stn/V2xr3KevwtAbPkGfUgbiSc90orJkpAw0is3Ywzn4ggh/wsnEsrl6
         UwyGdnQxp3AHraibSXL8kmEnaokWx/BJ/B3j8CT5ClBMAmaCICZiOMYlW28UHr9eDQ3I
         SC8/nINpjmRqGcWJtXGbdM5Vqmj6KTZsA39qYue+/pEimJtJwcxrkB4g87+d/BwMKmua
         GgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766523807; x=1767128607;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=butJpHnqQ90SHoGGD42cin4PuKq/RXOJvTfZuOfcYHA=;
        b=ueN/3CspCrv5uhAU44KN1ljQpQJF4nORPpv3xtlnDi7CNQ5tmIQICCTBn8uK+3Hskw
         LGByz+FSJJHsOW6em5O3d/HjDiIwNp0gPKC772npf3ftIiX6VK+0b62QhpL7U6AQbDoi
         y5ckPbwrTlbQqBo6vr0EpcZIfQox3j4zyvuDoSps3+fceXynVdVRjm2vpALcy6SYt+WY
         I759mCKjRx7boynBGORmw4Iz1fZI62UHXBUmXQoshYHabEtaiCgMPZ53nakhsOK3Tkd4
         G18eh5SNZBUPdn5IyK1VhFk3J+yFD+XwY7+BLVN1gmMiP4k2l4DnQzlZfdxjnlrKYZuV
         rRKg==
X-Gm-Message-State: AOJu0YwT64WuPd8L92LXHq6MfRt11BXw1K63Il2RkIWefu6t5FYHpkvi
	iaSnscvSW75NLM7gHt6Gra7wcsj8LSQNIYPgQotUmn7CIfhbT7hRyxcmVNeSeg==
X-Gm-Gg: AY/fxX7Y181XwTtuq1K/SN8bzsC/T1PBeuNfOdrwC8Yf7A3XISKhy4h6/7NFFriAYNu
	fiCyAqxL76lWSccxbU8wOU8s1KKt4X1TCYCGOuspJoI4CRMropVfKG3NerjHpsy+J5eRoxrtz/n
	mFWVbWCOHjVHlI9nk02KfLdNz9SxG6S2rEPk/RWSFydW8Svuh6VJDCAc6zGyaCDc/9AxW47aSKe
	q2JqUHl+Ze/HKEdl7A/8T+HzNKX6NRZWERiI84SdsN5dZPTdxW5Ns3x+BKtaoqH8wflSzvvmWLw
	9hqQHf0aPgoVxFvIIWgyyW4ok6qdddvOe0HCQ93mhdLK9dPAw9waavDh+hBcwqzUY+4G/qhng1R
	QRJkU9cE8cWVKP1VrEdxl+fQ7vwGFy6nWbRlDOtfRvcvGjDpH2fVD6KvrNmIDrkMBm5tyVJGUo8
	NayG5WN4wE/G8maekCnFwIpM3DhqcpJsAIEmsH/A==
X-Google-Smtp-Source: AGHT+IHb69XPld2UDlton51QdmHyU19tQ5x+Tzj7tUj5Ro45MZcbW6oCJb1zCophUEynndieSrEK3A==
X-Received: by 2002:a0c:e84a:0:b0:88a:2b3c:463c with SMTP id 6a1803df08f44-88d837932femr208998206d6.37.1766523806987;
        Tue, 23 Dec 2025 13:03:26 -0800 (PST)
Received: from localhost (pppoe-209-91-167-254.vianet.ca. [209.91.167.254])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d996b69c4sm113020586d6.36.2025.12.23.13.03.25
        for <yocto-patches@lists.yoctoproject.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 13:03:26 -0800 (PST)
Date: Tue, 23 Dec 2025 16:03:24 -0500
From: Trevor Woerner <twoerner@gmail.com>
To: yocto-patches@lists.yoctoproject.org
Subject: Re: [yocto-patches] [meta-rockchip][PATCH v2 1/5] kmeta
 reorganization
Message-ID: <20251223210324.GA37673@localhost>
References: <1883149997ED858B.1614991@lists.yoctoproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1883149997ED858B.1614991@lists.yoctoproject.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 23 Dec 2025 21:03:36 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/2866

Entire series applied to meta-rockchip, master branch.

