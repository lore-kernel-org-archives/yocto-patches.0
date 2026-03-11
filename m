Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0231125877
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 19:18:13 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4678.1773256688658714812
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 12:18:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Sw8YtWSD;
 spf=pass (domain: gmail.com, ip: 209.85.160.169, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5091d71aa11so3467001cf.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 12:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773256688; cv=none;
        d=google.com; s=arc-20240605;
        b=Jl46Pf3H4uV/Z/E9o/GkUJ06cy5I7gI/KuAm83IgzcGV1S2T0ZnZL4KsOfiRliAxU0
         QaHS1sebIAAFdLxzVpOuK+uyb9M1Zh6GOC81qNaoglF9SeSQtj/smB9KQAOcO0WhQ9h9
         khCIFp6BqTPVn5aRSo28jVv4aI16vWJ2o00d18Lq3G0gCiPifR5rYL7t03t1bLtsBLOx
         jP7T0CbMYCsMgTC0yutzkS/2mexTQmZjE2DwsmDGaDfcqc7cqgTnEbpmRmZTpNE/C0a5
         3vC78v4oBzz6bgcIaZhQJlJfA35zO8xLTxsK1NlCXUvBEl+1Fb78Lii9wZxNUrUZbO0n
         T16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+u4L5KgYBOa4Iya/YSrm0eg0+YLB+A8xskaRVVPpOaM=;
        fh=dl6hDswrRM/UxJNnYCvEBdIZalBhgR71Ri7j4SsRvWI=;
        b=Xla6CSqosvDC71AbeMXKrMmX8MGUYkXQwD/3QJTvvxeqpQCkd5mCzVCS2xCCvcOe2F
         DbXQ20HUokVM2W2N8PjrEfzCu3ARCNBXdOL6UP6Sd1Tc0uxxjQRV6rLzJg2zYnE3Aa3u
         k3J8BYRI1sogBPGAvJziu4ntp4JXEZ4Gdia97SqkrT0KsKHLCmOTw+iQopSkfTSqcYs1
         QjmMwzVLwKhupo2ZTOUQohryEUqtz5lBNXXkkwdp0wxcry97vjha52I+TtX1Bjr/b9hP
         QegtY1oUckmvgGd1FnYOzoboygKMQUYQtphsEkr51e+ITTrYb/nycqahhe6W+0EIMgP7
         UKjQ==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773256688; x=1773861488; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+u4L5KgYBOa4Iya/YSrm0eg0+YLB+A8xskaRVVPpOaM=;
        b=Sw8YtWSDERObZrOq+dcPTEuwjNtcQTcC+mdX0+pf0xTUBrHRSlNWmE5jr6KHEh5Ndj
         gdybHpBzNB4l70pvG7ip+b/1dHRLNyp1+iL6btlu4OYUjdaHovyIjvhHecmFyHy5KDC/
         fwx+8TyovHNMzad9nH5q0i/1DZrjJkHcJwTUDHKHuc4fS9VQ2EUGzDzbD1i+gKpuS8UD
         j47k1/gLdbrI3jlab0XkTOx3ysT2MrdTfZ5J2GW1b1Wsa1c+jxtMDQfNTyimglg0Bj4v
         J1Iq6lMLR+7hxWtxjS/cw6RJE3oEgT9YV4CkMmrkY/I4h1PlN/Nbi6yEUWkOoyPR65WW
         yqZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773256688; x=1773861488;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+u4L5KgYBOa4Iya/YSrm0eg0+YLB+A8xskaRVVPpOaM=;
        b=xSiWJx3nhOS7HzX3P5GdeGkgKI4HEyabtCeMGJn8vnXYfF7W5eIqXaPEogQRtm+QAB
         Ycibz+S3+s3SskxDMkrt4nsuBSPcPnYC6WBcnLgMNyLDLKSJqK8Q8FFotqwmp/3S+cvN
         StkcFqD99nzPbuo8vl6WoNG6OMgj0IhutS+7RcTpCEb9IGigE4TwOJLQpqlBtVKRIDiQ
         XgYZYDu48ckNJTQ1DlNtYYkuz+v5ijTQk2lvQEotJHtsF5cIqbDYw8EENWjgOTBb9PQM
         W0F6ajtNFSwaQZZkuVgvIKCuUezGhbTIe6fX4F7TEXVBv3x/pxwYifAE2AD/bjMJ8/j2
         ZO3g==
X-Gm-Message-State: AOJu0YwpZLacyCC76Qwk0v9SvWEJau9wRzLiaJzzMUHbJ/hp+4BGsEMe
	NvrU9aTfh/PgSCfZoPUIvRJvBSaqYCchxuJCAllnPg6osjIsCHkmkVRKvJ7FRyjCQn7og2phqow
	lq4cWP4RUUpO54q6Tce9iRfQN6CxiVfzu+A==
X-Gm-Gg: ATEYQzz257FmU1OmvyCCEFPTPF650bCvT5/9h+kG32R7kbV2gvEP9dBrtLQQY0Dbasr
	yMwM7OMm/fkDaGtj42QugBtrKXIjFmkZ06l90/mXaX2QO1AW1ByPQauE4EBNJ++mFb+PFxi0q/M
	yEdrnvMYzw4wUObXohViLMpBRJ6SeE6OWN1b7JoZgCK0Nf30sLFRcSJ0m3pdqsLx3/7lCCiQPol
	BtCIYF4ElveJK7jTYOAP/TMjA0Hz9hvasM8b5zd18djj36YQJPDcXM8tQBq9eZ3lpvXBirJG6qR
	umAFmE4o8wbKOXOd7eCh+qNn6WhUbovGBca/auBjXw==
X-Received: by 2002:a05:622a:10c:b0:509:465:1d78 with SMTP id
 d75a77b69052e-509472cde9emr9833311cf.35.1773256687585; Wed, 11 Mar 2026
 12:18:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260311064813.619683-1-Qi.Chen@windriver.com> <20260311064813.619683-12-Qi.Chen@windriver.com>
In-Reply-To: <20260311064813.619683-12-Qi.Chen@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 11 Mar 2026 20:17:56 +0100
X-Gm-Features: AaiRm53q1u9gq8kthP5iXOKzKJyz3jlLoP_wU6NSYStYUuk4Ge9I6nQOVxd6-c8
Message-ID: <CANNYZj8LQWVCJ+zgrAtaKU0oJHYtOPZpOiVHhHWi=LzmK_D9FA@mail.gmail.com>
Subject: Re: [auh][PATCH V2 12/12] upgrade-helper.py: respect recipe parameter
 from command line in case of layer mode
To: Qi.Chen@windriver.com
Cc: yocto-patches@lists.yoctoproject.org, randy.macleod@windriver.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 19:18:13 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3436

On Wed, 11 Mar 2026 at 07:48, <Qi.Chen@windriver.com> wrote:
\> The recipe parameter in command line is not respected. For example,
> upgrade-helper.py --config-file upgrade-helper/upgrade-helper.meta-python.conf python3-sqlparse
> This command still tries to upgrade all recipes from meta-python instead
> of just python3-sqlparse.
>
> This is a regression introduced by the following commit:
> ff1c2aa0d2 upgrade-helper.py: Add layer command line option
>
> Fix this regression by adding a filtering mechanism.

Thanks, the patchset otherwise looks okay, so if you can do the tweak
for patches 4/6 and resend, I'll take it.

Alex

