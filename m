Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 143A5CF5389
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 13:09:42 +0000 (UTC)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web11.8697.1729688973898452548
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 23 Oct 2024 06:09:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=TxjEEqaz;
 spf=pass (domain: gmail.com, ip: 209.85.167.46, mailfrom: alex.kanavin@gmail.com)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-53b13ea6b78so3267081e87.2
        for <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 06:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729688972; x=1730293772; darn=lists.yoctoproject.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fXilfr+1zhx9DYfo1eJ7Uzfoh5UuOsEYYEDHMQxBvoE=;
        b=TxjEEqazd/Ln5pxw+ypGnOWkLmnMbVNbeywIFovORkl0sjOeTrGskywMkCNEn4nUst
         YHJWWXSqwnhQ+LUu7jBlTenQmgwahqFvdPb8b2IumtvOsyLAf2VshhMzJLQaHTt495SC
         NCEP0A4/s4ahJ6QmcwYeM1ss7CLt1QpbizCWRVSxlM8P58Xf9E9kqBWyvIZTmbSYeysT
         n+IqPQZrs0BQtP+FVk6Wr02efikTQamAhaC0bkLVRCg+9KgPfF3uk6kCjel0vHHT8ju2
         5Z7plMlU12YE5jz1AK7GDqoUHQO4gIw0ciSsNFucCCQns2Ghaj4fS2b+BpIs8TePbBoI
         x2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729688972; x=1730293772;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXilfr+1zhx9DYfo1eJ7Uzfoh5UuOsEYYEDHMQxBvoE=;
        b=wx3JwRt1qak5Rk4Fg+ve4/+eLtoklIJ/pjs5fN/2/R2z8Y5nPezh6y+4j7yqhwpq18
         d6jivqO2136Ko1Q3FTT6Y/JgXDU4CobGBND0OINrlO3Vo2YZTOK+ihfAtmTUpBfC2+Ky
         LhgE228sqRx1WJFQCEFJcq7WKlraXZy4EcR72Z9aFQJq4LIwiKKBY1xdOPK6B0HEHZqL
         gVtEeeB2+nm2tqWINZIROSlxqh9FiQyB07aZ8DX6Xr1idnDa3cj2GTkflCSEE2evr0L2
         wTncNrNAJcEsbGMQr1J2QYJkOhlqIXd6n1SBTvWp0ZJ1MBhNDiItaKOXkkLRwImDlVQ1
         eRyg==
X-Gm-Message-State: AOJu0YxKXO3ukI3LlXGj1+86BY+UKcTFGDo2cjz2/yjAW1kYaDUUUX/r
	rnwveXRjM8SEm5o0fx/Zyt330r1oM6Z9NSzcWWEMJbmCIB0I+dKApgWo+o7YnfmWaCQjcwdz6Eo
	O1RNiWOLV0aOcvA1SjEaJlZfd3DUfHgmX
X-Google-Smtp-Source: AGHT+IGEdrJ1S+6PeXFzJwYwVBzKKcoZGCiYNpP+rzuauB+kQvfZpydigEUJ7l+F7CSxcurAWAgIUo6wnQ9QakVLUY8=
X-Received: by 2002:a05:6512:3d06:b0:539:9720:99dc with SMTP id
 2adb3069b0e04-53b1a39ae7dmr2129953e87.46.1729688971373; Wed, 23 Oct 2024
 06:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <CANNYZj9jbBRzi=KO1e5SA6k8xfP=32_F2d2FWG2gEUxo0fdKHw@mail.gmail.com>
 <17198.1729680399957383754@lists.yoctoproject.org>
In-Reply-To: <17198.1729680399957383754@lists.yoctoproject.org>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 23 Oct 2024 15:09:19 +0200
Message-ID: <CANNYZj-jKcPW8cSiBmiXJHnrf96vLybi25EeqxnmJUnLQ-k7rQ@mail.gmail.com>
Subject: Re: [yocto-patches] [matchbox-panel-2 v2] panel: added sysfs support
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 23 Oct 2024 13:09:42 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/737

On Wed, 23 Oct 2024 at 12:46, Dixit Parmar via lists.yoctoproject.org
<dixitparmar19=gmail.com@lists.yoctoproject.org> wrote:
>
> Alex, Okay, thanks. If you have some examples handy, can you show them (mentioning the personal copyrights)?

You can find them anywhere. For example in Linux kernel:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/kernel/irq.c

The important thing is that it must say who holds the copyright, and
what the license is (in the form of spdx identifier). If you add to an
existing project, the license should follow the rest of the project.

Alex

