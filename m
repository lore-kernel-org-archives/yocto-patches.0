Return-Path: <martin.jansa@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DBAEB107C
	for <webhook@archiver.kernel.org>; Tue, 10 Mar 2026 15:53:50 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.43428.1773158029133138757
 for <yocto-patches@lists.yoctoproject.org>;
 Tue, 10 Mar 2026 08:53:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A7JL4STF;
 spf=pass (domain: gmail.com, ip: 209.85.208.180, mailfrom: martin.jansa@gmail.com)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a2f92fab4so62431261fa.2
        for <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 08:53:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773158027; cv=none;
        d=google.com; s=arc-20240605;
        b=Hp2tTn3B4bAsivW4y/ye1KlgjcUL1aqzGOUR4hPyqslCakvdTJasXYIl7JnHAWnHMQ
         Q3agGJMwbp++Z1r4qZNQ4FgtVaHcF9jrGjKX7zuWThvBBToPG7SVnYHigvDa5K4Z5gAL
         4J7SW2hbyRwYG8gZA/JhLUmSgnt8I8/UOwr6pqVHtmhvksCP0xbSFNHLjEkRJYSmJwE6
         y/GTLZEdoefOzobs7C14xJoMlinyNtdWTsgsXoSxj+ueojeN3Gcrv3sPdtMIhnS4yCUP
         HJfY0o18vqpNno8ozfG4xNNFkdKp7pQx+EHiYWaKp9lGZywqhWFljlWL4AilcljJJfZa
         kQtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E3osnanDuHBRADEbzlroISiwBQDtCi0ZFU2ZOOC0IvQ=;
        fh=moagCLbVVFQO5kw1aLdWVpJz+dpYgsdIWNCHzBu4K0w=;
        b=HsPsHx+6kr2vUYSa1/kN+uQELs9IATTzUEeM9EecRNXUhv+TINhHcmBx2UvImkiRUX
         osdCj8vTbwlwsZ8j70ptFI0DC5JghBo9dZdOjKlYPqjjS6GNC8HMrM9MzH3zA6m30U4J
         5C0UnERVSXt/j3hsS37MvoOMSZqb8/sOXpBtHO9rIV0Rj+BJQXSH8jVGaduylngEJF2u
         ANVsWRYTnZW2tp+NcDrpC3At4kvI9TjUn/ztRK+4Zsokrab/AL/QxbIDS8eiYITGizNz
         O9p3VvBbVyuxG//1kK69TH1grGFOAnvrIY0KbXgi3Kx4oCfscSPxH2G4pyC20xP7t0ck
         UhTg==;
        darn=lists.yoctoproject.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773158027; x=1773762827; darn=lists.yoctoproject.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3osnanDuHBRADEbzlroISiwBQDtCi0ZFU2ZOOC0IvQ=;
        b=A7JL4STFh+Y4cGJlRBtqZG+eEM9VfJ4rfm5jsI6hHe2O0/P9LDnlvN5tIDXBGgtVZL
         E/SOoJjEkBsC+5FEz4dxrZyw4z8orkQt/Qp5VBNqmzuhhpQMHk3J8o+Bm9s9rMsRTllC
         q1UZhyI8jXSm5qYW7a3x/h0jGkXrx95J9jEctW7akqfta3yHVadPJje0Hx19wwqRc1s8
         zBglv0Zk6rj1D6EXdAK5pM1bp52Lm2lrZOUQz68vS4W/jrWWVvXoylW/0i5qXRgmJFrY
         zd7GsooOrN4PkugYqpvlVmPmugPrYUNBUXIKSVkcPeg026+U6EkhBlOca7U5tp9U9gjs
         cfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773158027; x=1773762827;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E3osnanDuHBRADEbzlroISiwBQDtCi0ZFU2ZOOC0IvQ=;
        b=hCubgNPcJlVUn4xBapPSXPiKIn4lvCWq0pApBH1hhFaypwe25AIhJpeFDtBXeQ8xXJ
         mAG9vmSN8cFc7swPs0wI8Z7TFOi6c/nqQUPPxacJnt9wFCscS+KB3miVaKkQjQlp9P0K
         7W90hbvYs7LKaayWZlHAb+XheH8iU7neqlTC719prvkpQ33pn184iBbsPyZ35NusvnyI
         nKO0AuAIUudK4Kyhq67GNWI4gR8/AEfN546QMkhO6Uy/hhOUe0IDcuF+sMIdl/7H5cfc
         kW6o6D5hVFCZWbmq1ZWtmfVg0Y9NAe+bRpfKO3405h9sUkc2mu5eza1bnhFEVSNXBxMg
         drSg==
X-Gm-Message-State: AOJu0Yyns9b17oIf7Hj5ljCT+u+Le01bPtnMdQ5WH8HNFuGXlwYtM+05
	OQGmKoxM47tJiKe1jhxfFi2bv/LJN7qp8c8mWJHAgUvQFPehUNk7VODdr8K1FaimzVrzZNUcAxV
	eDratP4amu94YDyEB+KIZvDFOdaOvqBRE6Q==
X-Gm-Gg: ATEYQzzNxo5hgog/HVkx5wAvtDSfFP6Sencj9Z6wYTtgHRW0T73TdvxzEN7fMzNsUWz
	tTavWwLQK0YeBSIi7HoCT/+DzV754lbuCWb1DUTSoU03HJs+UI+Eu5UYyeecp6AROmdddX/PC8x
	U0fWdModUBzcoj6Xd6QJbw0sQP3NmVHbML/a2cXQXpim++LAojgiuq1Baf+qrcT3+fQSDHvfwu3
	D8nbSWaJB2IswK/MPq/AVgoOk0+AS6l6FEQEU/NLtsG94qI2m5WLlJZaEWxiIUjA+w+HZYcV5VL
	F5w2gczkNQ==
X-Received: by 2002:a2e:a555:0:b0:383:20cd:52fe with SMTP id
 38308e7fff4ca-38a40b6433bmr49217731fa.17.1773158026937; Tue, 10 Mar 2026
 08:53:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260310102739.2743995-1-martin.jansa@gmail.com> <cd091aba-6902-eda8-83b9-ade077fb881b@konsulko.com>
In-Reply-To: <cd091aba-6902-eda8-83b9-ade077fb881b@konsulko.com>
From: Martin Jansa <martin.jansa@gmail.com>
Date: Tue, 10 Mar 2026 16:53:32 +0100
X-Gm-Features: AaiRm51BtqahJ5SsverrYpwC6aBChkUaC-DIMufPWHXSfhnjrxPVB6_G1kaHUiA
Message-ID: <CA+chaQfb5sKf-nE=+UDOB5KS5rF=+YuWWr1sBFGXr=EK+Mf8zw@mail.gmail.com>
Subject: Re: [yocto-patches] [meta-security][kirkstone][PATCH 1/4]
 meta-security: move perl and python recipes to dynamic layers structure
To: yocto-patches@lists.yoctoproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <yocto-patches.lists.yoctoproject.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <yocto-patches@lists.yoctoproject.org>; Tue, 10 Mar 2026 15:53:50 -0000
X-Groupsio-URL: https://lists.yoctoproject.org/g/yocto-patches/message/3396

On Tue, Mar 10, 2026 at 4:45=E2=80=AFPM Scott Murray via
lists.yoctoproject.org
<scott.murray=3Dkonsulko.com@lists.yoctoproject.org> wrote:
>
> On Tue, 10 Mar 2026, Martin Jansa via lists.yoctoproject.org wrote:
>
> I'm curious what the motivation is to backport this with 2 months before
> kirkstone EOL?

Just that it builds correctly in bitbake world (which I've executed
with meta-security included after long time - that's why I haven't
sent this earlier). I though it's safe enough to be accepted even
while being close to EOL.

