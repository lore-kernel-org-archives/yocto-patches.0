Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6101125875
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 19:10:32 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4375.1773256224201407655
 for <yocto-patches@lists.yoctoproject.org>;
 Wed, 11 Mar 2026 12:10:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QbA9EUTZ;
 spf=pass (domain: gmail.com, ip: 209.85.219.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899ee491af3so2493406d6.1
        for <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 12:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773256223; cv=none;
        d=google.com; s=arc-20240605;
        b=VzHfM8Fyt87CV307sc2vvHLfImA+QkBt5hyNsASpcb5jUMPjwghuRBn06Z9tk5cxPt
         9ueWs+4ZyUnTevx5Q9TgM4Ylk5mD9s3Gw8FTBVPtXQWCHFkZNtIGEx8Ynn+rx6xHc5yy
         eZrvNJXKl0usqohN06wq8idUCCBm+lCy7kCIzMJVE0ImVkyDg8y7B/ih/IXmjmfQHZFl
         PM5718KSWmAdBjKZxpBCpbl1IVIfj1orfPiw+ohZlWZ2v9ztY2FnTCyg6qK6iFih6dyw
         EAx5JgrGlwJMxBBFv8cA3lK734KV1EOitbfVUIk14mdDI4dM2XZlgs06lFsiOhI/GksH
         3WPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h6leZ7WrrgA6LeuwuObtB/kYKKtM4bJIX8s7hcbU0Pw=;
        fh=dl6hDswrRM/UxJNnYCvEBdIZalBhgR71Ri7j4SsRvWI=;
        b=dLochXAsRIAb7E5SOaEabgyBbieuwar05V1QsnFkZIE2fZkyktD+wogEOyLmnAeLmL
         wc4eJoNZ85/OebICWB9PQsGZrAFSJP2K3eYSutn0UTMmqsFCySoZyX7p1XKbeUomWZVd
         kZ2OaOWsTQosBY1Mut7yBoZTwe5b2XmhKukAvlEgOQ+/fbNGNjMi772pz5s2VILmKuWg
         5Kn3l55rqtinU+EzUef0/q2pV7+hjBqouUXbAwahSAnCJczdI7nezSh1Ls2vhXoOKhZo
         bpOytWEHl8fjCDGwl+IZFIPvuSOYEAXgDAGqdIIklc31Ew5NjUdvnha0rYlw81ZXNq1+
         xjmg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773256223; x=1773861023; darn=lists.yoctoproject.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h6leZ7WrrgA6LeuwuObtB/kYKKtM4bJIX8s7hcbU0Pw=;
        b=QbA9EUTZnaHl1pWiGqjm+Lon6B7Se0g2HbX8aKhKkesOe5Kmb5sSI7fL2SEueBM7iq
         RRNDzegA+Z7yipQKPOqWT2v5gHHje44nU+Iw0C4Lirfso1jL00JGy3kpP1im64e6v+N7
         F2ztSwGAtr6JF1ucpKhwlZ5GOSASKEYmfxnn0BlC66cCnClvqjxOswhQUeyR4eT4RKK/
         f52DNQzikCxKfGHOAyLYx7ILpfH9rQQm6vGpe2bEHvstHMmg19jUm76yOn3FuMaQu4+G
         NDiQpSzwAgrhdwCaYa9/As66SRZtpZ+G1sVWLX/7lZ6zkFUpMRodqpjibuwR2TPCthKQ
         wwPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773256223; x=1773861023;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h6leZ7WrrgA6LeuwuObtB/kYKKtM4bJIX8s7hcbU0Pw=;
        b=tYQAL4mTFNZsAX1zg8uNCO6pMBeIgLvTARSrFjWK5goTOr1hp7KwZvpRYze2mKtiKh
         mLvOvoj28zjThVvtEewjbMi39RRcGvVjodah5WPTE8Q2YbpEbXvUEOZojZijy9HUeSwr
         Wrjqv719mN7C+OVKk/6ppRfq8rR3H+2ZzKfCAjmkz2B3vmEd2KrCUHwHa6JRNsB/UHFH
         49z2pzlKXvhy/CXNHgVjEBA6DUF3DtE+xBpdlWvYK/BdQu9zNjoMwgsSBQanzMZJDKUa
         +ns6UwDM3wzixgdpVxiZFS9F3QJbJ3XKKr0KPQlLrNBatqBV2v4NbXIuJUi+jmjlR6Jm
         s4Vw==
X-Gm-Message-State: AOJu0YwENUjd1u8tUorSqbHEDN+PHRSaGPwPEbYWqmqL0lqQfMRf1nZ8
	UC4SIQjmufDpvxLIYoRTTRtP1jyfYuRRTOriVi9F5PU1d23b0oY2RZVEVfFORPjaJFs0VEuhkDf
	Fx5niMPQpovo+e2cfXiJcbvZFparWXs8=
X-Gm-Gg: ATEYQzz/lIgj2j+Lnlk9zO1uBApucy6vEtKS6cTEYha3cvAWylX/3/InlhXoKRUeMvC
	XFYOiTJaILkqXD2JJcBKYa+Ej8orBE7fXPlZ7AI9dzOKZoqdr87havu7T3xjDlkGh+RBBupVEzJ
	jnHYrEXYtTTdJHVZPhnPfUnnp2fv/5n7DvSTJZPncuKl7o3xKoAT/JFlLN5Bwgd/33V4ydXx2QG
	qsJHGXj90ArgGzYIc+GMghauTzgxrAD9BKb36SZDiyxBzlVW+YYiYTF21yq989AA+fHu6i9pWE1
	E7Fq7LxQcI4sj0MN6CzGUjw+2m6tVgWbdGKK3DMcGw==
X-Received: by 2002:a05:6214:768:b0:89a:f10:996e with SMTP id
 6a1803df08f44-89a66a24057mr54475846d6.6.1773256223083; Wed, 11 Mar 2026
 12:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260311064813.619683-1-Qi.Chen@windriver.com> <20260311064813.619683-6-Qi.Chen@windriver.com>
In-Reply-To: <20260311064813.619683-6-Qi.Chen@windriver.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Wed, 11 Mar 2026 20:10:11 +0100
X-Gm-Features: AaiRm50QDGYt834HbtiY0H61JWuVIj5WXmd3wZ1ED53MPky3uqqusEdd5lE7wYo
Message-ID: <CANNYZj8ZA0vN3FuUNaUktXvL_XpFm_GT=nB6g0KJQCz2Yx-5eA@mail.gmail.com>
Subject: Re: [auh][PATCH V2 06/12] modules/utils/git.py: include repo_dir
 information in the raised exception
To: Qi.Chen@windriver.com
Cc: yocto-patches@lists.yoctoproject.org, randy.macleod@windriver.com
Content-Type: text/plain; charset="UTF-8"
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Wed, 11 Mar 2026 19:10:32 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3435

On Wed, 11 Mar 2026 at 07:48, <Qi.Chen@windriver.com> wrote:
>              stdout, stderr = bb.process.run(cmd)
>          except bb.process.ExecutionError as e:
>              W("%s executed from %s returned:\n%s" % (cmd, self.repo_dir, e.__str__()))
> -            raise Error("The following git command failed: " + operation,
> +            raise Error("The following git command failed in %s: %s" % (self.repo_dir, operation),
>                          e.stdout, e.stderr)

Hello Chen,

can you combine patch 4 and 6 (this one) into a single patch that
removes the debug/warning print, and just puts all relevant
information into the exception?

The reason is that:
- auh works in such a way that having git fail is sometimes okay, and
the caller will handle the exception (e.g. see the 'nothing to commit'
handling in upgrade-helper.py)
- if git does fail, we don't want to flood the console with warnings
when it is not a real failure. Rather just handle the exception, or if
there's no handler, then it will be raised and print everything
relevant.

Alex

