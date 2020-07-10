NEWRUNITEM = " \\ \n    && "
NEWLINE = "\n"


def generate_dockerfile(context):
    return f"""
FROM {context["FROM"]}

{NEWLINE.join([f"ENV {env}={value}" for env, value in context.get("ENV", [])])}

{NEWLINE.join([f"COPY {source} {target}" for source, target in context.get("COPY", [])])}

RUN {NEWRUNITEM[:-3]}{NEWRUNITEM.join([run for run in context['RUN']])}

{""if not context["ENTRYPOINT"] else f"ENTRYPOINT {context['ENTRYPOINT']}"}

{NEWLINE.join([f'LABEL {label}="{value}"' for label, value in context.get("LABEL", [])])}
"""[
        1:-1
    ]

