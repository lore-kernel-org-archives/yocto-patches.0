Return-Path: <hfranco@baylibre.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFDAFED9FA
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 17:41:02 +0000 (UTC)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.82019.1773769260122623239
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 17 Mar 2026 10:41:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@baylibre-com.20230601.gappssmtp.com header.s=20230601 header.b=va0/QX+1;
 spf=pass (domain: baylibre.com, ip: 74.125.82.178, mailfrom: hfranco@baylibre.com)
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c0e3a2605fso622194eec.0
        for <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773769259; x=1774374059; darn=lists.yoctoproject.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p/Mh/jKO2fi6W0WOHJ25gGl9mMoTW+oSodVpnVO/cgU=;
        b=va0/QX+1VWJDz/pKrB6c+HUBlVTlCg30Iij4Y5NXuww/I4zJl6y56q21lnKn+tMEWH
         1MG3axzxJfREJ2jxgTkc6vGgCbxLJRTXvSU5AGNEUy6xM+x+vGlha1fcWi8DbGBeXNgl
         fhaieg7z+FMnN4+dXxuYdzpKj70p24EsnB27frwSBH8zMCAjVBGYRkddBFCJ7veYT8Y5
         eFRs2JuvYu3wwrpE8wSNYMbWEKRGqna3ftFObMA9+ynN4DXNqUa6GQXZ7MPtRgYPpYzl
         oWOV3OGegK8s3wr9nU2f3+8GnqEHPy98EUhE82GBoB7KS9CJ4U6q3yPN34muS2wzNvgn
         vNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773769259; x=1774374059;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p/Mh/jKO2fi6W0WOHJ25gGl9mMoTW+oSodVpnVO/cgU=;
        b=CD+2SQSmHETZ96kub5QK9w3wZ/rN3ghhUT+arMfXIDYKJ5Otghr/wAdwrhU1mPT+RW
         y4QbaTZGyDq+pXbb/LQNQ1Ruk6+dsn6WIcF5Qi2B2pDhAm5KhPchwSWl1kR9osmV278j
         r6kgwigm6iYLbL72FP9VWa7u9fqx0B3IiPzoLvlpkoyvU462DlyUUABbvQ64LERUGKTj
         LlCq84pdJOWqN4mmMSnxvuMfGU2PyZY8WfDdhgBvAAD8/KuuZN1RvRnmTuCNPM6PeP2h
         fHrAmtQtXmEXCUtgfKQrZq05p8XfyQF0lSocDOkWHVnTadBNmZc3NMiBfz7C+xmF+h/A
         vS1A==
X-Gm-Message-State: AOJu0YzANuooEWYr2TFUIR0VywoOIHz/cWEXSBcqAnN+w0ojmgkTGgUu
	ISYy4bGj+sdyHMaxyxogjbFjB5EOVwkYYI0Mu206Hn6su2LdAKiMsDQNv5etEq9I+wc=
X-Gm-Gg: ATEYQzzduNsVniJJC04RX/RIaWCaMx1zpiTnM0LO7TDPc2pM0WZsLMwp0rR+aduirvA
	2CACpYI0DroCrG57rZA22h9ltnjhLf+841kdN0SYKn39nr7POZLq52nudKcXkqeurXyDkRByYID
	9Mp4f1/w/QZt7dWgmhUJVNInipYOyNAZ+DIMbGLPev5UePu490pnDWwO9Ei2bDYSz+UhuiVx/fP
	JsGuMrHUzBbHbRk6nXvVbHqXYsAiZo/daxHV1t+ljx3ckktTOAJ/hfhx9JzhwH7lJSUyFy/C9vz
	aMWrIIKFabCETyXebVoxjhJlwNdJfzkFWELc4EWEnwIC8NorvU1SQWPR7+Kq2wjIZkvZUFJkvHE
	vXwS/uVZwqNdx7YClWnQyoJ/JG65lJpkTKeb/1Jx4IE0IVpAnsryYefACdM2KuiKR9Tb/j7uyC4
	nIesMDo75Wb3O5/NAaTo+IogsHA4JyynBmi/ax9c+pArTHOYaVDiE0bXboBo5wjHxgdToFtoXYS
	w==
X-Received: by 2002:a05:7300:2d24:b0:2c0:da6f:55e0 with SMTP id 5a478bee46e88-2c0e510f680mr139198eec.27.1773769258887;
        Tue, 17 Mar 2026 10:40:58 -0700 (PDT)
Received: from hiagonb ([2804:1b3:a7c0:c4f1:ec8d:3c3c:583d:3ed])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e536893fsm200457eec.2.2026.03.17.10.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 10:40:58 -0700 (PDT)
Date: Tue, 17 Mar 2026 14:40:53 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: yocto-patches@lists.yoctoproject.org, Yi Zhao <yi.zhao@windriver.com>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [yocto-patches] [meta-selinux][PATCH] Enable SELinux support in
 native packages
Message-ID: <pfqfrlcduuigcvfdvn5ljjmjomee2wwn7xxu5ikibinoz57udn@dusca2fnhwja>
References: <20260213154238.4093604-2-u.kleine-koenig@baylibre.com>
 <baff51f1-f0d9-4ae3-ba7f-bcbf1c0272c3@windriver.com>
 <14ad3c9da707249caf3f5157cf9be0b936ebfe5e.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14ad3c9da707249caf3f5157cf9be0b936ebfe5e.camel@linuxfoundation.org>
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 17 Mar 2026 17:41:02 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3491

Hi Richard,

On Mon, Mar 09, 2026 at 02:21:51PM +0000, Richard Purdie wrote:
> On Mon, 2026-03-09 at 20:23 +0800, Yi Zhao via lists.yoctoproject.org wrote:
> > 
> > On 2/13/26 23:42, "Uwe Kleine-K�nig wrote:
> > > With SELinux enabled for the target it makes sense to have SELinux
> > > support enabled for the native tools, too.
> > > 
> > > Note that for native packages DISTRO_FEATURES is filtered, thus up to now
> > > it never contained "selinux". Append to DISTRO_FEATURES_FILTER_NATIVE to
> > > make "selinux" propagate also to DISTRO_FEATURES for native packages.
> > > ---
> > > Hello,
> > > 
> > > I use this on scarthgap, but the patch applies fine to master, too.
> > > 
> > > During a debug session it took me quite a while to find out why
> > > 
> > > 	ls -lZ "${IMAGE_ROOTFS}
> > > 
> > > at the end of selinux_set_labels() didn't show the labels added by
> > > setfiles.
> > > 
> > > Best regards
> > > Uwe
> > > 
> > > � classes/enable-selinux.bbclass | 2 +-
> > > � conf/layer.conf��������������� | 4 ++++
> > > � 2 files changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/classes/enable-selinux.bbclass b/classes/enable-selinux.bbclass
> > > index 3dc61d6931ff..0c9f52e74cec 100644
> > > --- a/classes/enable-selinux.bbclass
> > > +++ b/classes/enable-selinux.bbclass
> > > @@ -1,3 +1,3 @@
> > > � inherit selinux
> > > � 
> > > -PACKAGECONFIG:append = " ${@target_selinux(d, 'selinux')}"
> > > +PACKAGECONFIG:append = " ${@bb.utils.filter('DISTRO_FEATURES', 'selinux', d)}"
> > > diff --git a/conf/layer.conf b/conf/layer.conf
> > > index 4e04e5cc7e6a..ca981db57019 100644
> > > --- a/conf/layer.conf
> > > +++ b/conf/layer.conf
> > > @@ -25,3 +25,7 @@ LAYERDEPENDS_selinux = " \
> > > � "
> > > � 
> > > � PREFERRED_PROVIDER_virtual/refpolicy ??= "refpolicy-targeted"
> > > +
> > > +# With target support for SELinux it is very helpful during debug when the
> > > +# native tools support SELinux, too.
> > > +DISTRO_FEATURES_FILTER_NATIVE:append = " selinux"
> > 
> > Can we add this to the doc (e.g. README) instead of enabling it directly 
> > in layer.conf? Since we haven't directly enabled DISTRO_FEATURES = 
> > "selinux" in layer.conf either.
> 
> I just wanted to add that putting that directly in layer.conf will mean
> the layer isn't Yocto Project Compatible too.

I am going to send a v2 and take over this work, already asked Uwe about
that.

But before doing it, I was wondering why changing layer.conf will make
the layer not compatible with Yocto Project anymore. Can you explain to
us the reason?

> 
> Cheers,
> 
> Richard
> 

Thanks!

Hiago.

