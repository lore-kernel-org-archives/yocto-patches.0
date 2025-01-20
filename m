Return-Path: <scott.murray@konsulko.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C24C02181
	for <webhook@archiver.kernel.org>; Mon, 20 Jan 2025 21:32:48 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web10.1872.1737408766092090952
 for <yocto-patches@lists.yoctoproject.org>;
 Mon, 20 Jan 2025 13:32:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@konsulko.com header.s=google header.b=Epwb2js3;
 spf=pass (domain: konsulko.com, ip: 209.85.222.173, mailfrom: scott.murray@konsulko.com)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6e9586b82so418003285a.1
        for <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 13:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google; t=1737408765; x=1738013565; darn=lists.yoctoproject.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IzPnZtQDa48WfRWx+XHKS+CzTljna49YfjNhBYidFLE=;
        b=Epwb2js3CjN5IINZQcXO+YJAXK4JRvcu2Phmno1VqIznd6048uNUJOSigLiBvdB9yL
         IU9L93r+yuccKKekYBcpDObtGxhPORSu/Shnnf5GOs05vkMIMIZ9EYTarkUgWOu1xC3I
         z/SeEuDXC+vBG22WnwppZZEMkGL9GMwsMh9fI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737408765; x=1738013565;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzPnZtQDa48WfRWx+XHKS+CzTljna49YfjNhBYidFLE=;
        b=MNeLqzhZ4WJDbG+SjC4Lhwqg7yflShjF9eSQg92DRaMQc859IRurf6Wd9ev8X5LtN9
         yqZzYVlm3f9h+UB93YAEfvDaLusLymEq+qn8quvuFs3gZWW02QCRoc0csM5VPRDDEiec
         Gen37UcEIigvaeIdhAwpNQ7R8joboVwjUscHMlJIFWI8iUC99kdPhH4n8OAK9AOc+gmq
         D5+2zukkbhaLmWBGL8CJwibgmlcpJejACouda1U/cszhwFleuUEezY3rDxQaMfkt7e+H
         0jOwHQ+sAYJKqgCytR0vESA8Lt+GeRI8cj6/nkPT/JmP07/ukml8Z+s28QQw7Z1dvvPB
         aO0A==
X-Gm-Message-State: AOJu0YzQgUOWzdOh4YDs5DFBk+2hD2Y6IRJ/PV7EkEf6VsCL2dLFJTIH
	osW52WqP2NsJJU09H3pNyFjbj24LlI9fqSzmh3W2jMP8jNVDg5r66uye4HLbhuI=
X-Gm-Gg: ASbGncuyazv++4rd3KDK3gwhUJrmGzlMKNLtVc59kFcsRwxMkdONUfD32zGir3FPGnb
	Rm/Cju5uC27gdPAzioA/LXqRuhl0nNOG9sXHRa6CLpCDug4qOrk8K2Akkaxo8dGVZJ7ELy23ii7
	4ELqm52zjo6/idq6sMZ2NcwWUedx0MTNVWrvJugz+KawwufKA0pXweKn5AbvsfPelX88cP3BJ5y
	berEc58rkTF9QJcEwpCWZjTuJsySPyoostvIY8qzS1m8iI3ECbPXmYM7I6R/3vpRMvtN31A5ZZx
	fqWCGE5Y+iOYs6u68ZHF/3lP5B0O
X-Google-Smtp-Source: AGHT+IG9lNl1cKbpoqNpgN49pjViVFoUteH88kBg5PBaH/XkxB6JzPcn5Jx7rCuAZgbABeqXUk8+kw==
X-Received: by 2002:a05:620a:43a6:b0:7b6:d939:f958 with SMTP id af79cd13be357-7be63247d43mr2738127585a.25.1737408765082;
        Mon, 20 Jan 2025 13:32:45 -0800 (PST)
Received: from godzilla (107-179-213-3.cpe.teksavvy.com. [107.179.213.3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be614ef1b2sm482146385a.106.2025.01.20.13.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 13:32:44 -0800 (PST)
Date: Mon, 20 Jan 2025 16:32:43 -0500 (EST)
From: Scott Murray <scott.murray@konsulko.com>
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
cc: yocto-patches@lists.yoctoproject.org, 
    openembedded-core@lists.openembedded.org
Subject: Re: [meta-lts-mixins][scarthgap/rust][PATCH] classes: rename to
 classes-recipes/
In-Reply-To: <lybjw1ffw0.fsf@ensc-pc.intern.sigma-chemnitz.de>
Message-ID: <a5630788-8f4a-faa2-7d6b-8dc87dd1642c@konsulko.com>
References: <20250120165117.737681-1-enrico.scholz@sigma-chemnitz.de> <1f6cdeb4-c868-e32c-4372-123371eb4b12@konsulko.com> <lybjw1ffw0.fsf@ensc-pc.intern.sigma-chemnitz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Mon, 20 Jan 2025 21:32:48 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/996

On Mon, 20 Jan 2025, Enrico Scholz wrote:

> Scott Murray <scott.murray@konsulko.com> writes:
>
> >> bitbake looks first in 'classes-recipes/' and then in 'classes/'.
> >> Hence, content had no effect and was just ignored.
> >>
> >> Rename folder so that it overrides the OE-core classes.
> >>
> >> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> > [snip]
> >
> > I'm pretty sure this is incorrect.
>
> Logic is in [1]
>
> --> first iterate (using $BBPATH) in 'recipes-%', then in 'recipes'

Hmm, the code I looked at was in lib/bblayers/query.py, and its logic is
different AFAICT.  Can you confirm that "bitbake-layers show-overlayed"
shows it as being overlayed for you as it does for me?  That it does
would seem to indicate a bblayers bug, and there is perhaps some missing
documentation of this behavior (change) (e.g. I don't see any mention of
classes-global vs classes-recipe vs classes and how their prioritization
works wrt layers in the docs).  I'm CC'ing oe-core just in case I'm
really missing something here...

> For now, it does not matter because classes in OE core and meta-lts-mixins
> are very similar.  But 1.81 seems to introduce other data layouts so correct
> classes are probably important.
>
> I stumpled across it while fixing cargo-native build errors [2]

Okay, I'll queue it up once I have some cycles to do some test builds
here.

> Enrico
>
> Footnotes:
> [1]  https://github.com/openembedded/bitbake/blob/0329a7e3ac694737f2d2c1861f65492551360663/lib/bb/parse/parse_py/BBHandler.py#L53-L68
>
> [2]  https://lists.openembedded.org/g/openembedded-core/message/210043
>
>

Scott


