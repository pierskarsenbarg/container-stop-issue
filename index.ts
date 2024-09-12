import * as k8s from "@pulumi/kubernetes";

const appLabel = { app: "hello-world" };

const namespace = new k8s.core.v1.Namespace("appnamespace");

// const deployment = new k8s.apps.v1.Deployment("app-deployment", {
//     metadata: {
//         namespace: namespace.metadata.name
//     },
//     spec: {
//         selector: {
//             matchLabels: appLabel
//         },
//         template: {
//             metadata: {labels: appLabel},
//             spec: {
//                 containers: [{
//                     name: "hello-world",
//                     image: "pierskarsenbarg/hello-world-app",
//                     ports: [{
//                         containerPort: 8080,
//                         hostPort: 8080
//                     }]
//                 }],
//             }
//         }
//     }
// });

