class ListVariables{
  Map Muscles={'Day1':'abdominals', 'Day2':'abductors','Day3':'biceps',
    'Day4':'calves','Day5':'chest','Day6':"forearms",
    'Day7':'glutes', 'Day8':'hamstrings', 'Day9':'lats',
    'Day10':'lower_back','Day11': 'middle_back', 'Day12':'neck',
    'Day13':'traps', 'Day14':'quadriceps','Day15':'triceps'};
  List exeImages=['https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FAbdominals1.jpg?alt=media&token=020e11d1-ca63-42b9-8a37-e5d898115f0d',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FAbductors2.jpg?alt=media&token=f3e1d9c8-87ed-4939-aa98-896ee7eb5001',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FBiceps1.jpg?alt=media&token=8a03358f-efe3-4f94-9aa0-2f0815c01c21',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FCalves2.jpg?alt=media&token=78fca83e-66f1-4ff1-a733-df63e595239b',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FChest1.jpg?alt=media&token=ac0b8dc2-5ecb-4b63-a1b3-c2eec0a290c3',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FForearms2.jpg?alt=media&token=17568483-cac9-49d4-be7f-4638d504cb53',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FGlutes2.jpg?alt=media&token=c637af96-25f8-4978-83d3-e19f859483a7',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FHamstrings2.jpg?alt=media&token=37c9a017-2e56-43ab-b091-870929c3f89e',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FLats2.jpg?alt=media&token=c9b0df82-b518-418d-9bb7-1de7924cc31a',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FLower_Back1.jpg?alt=media&token=971617ff-cf87-476f-a615-9fc2ed524c73',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FMiddle_Back2.jpg?alt=media&token=c061f905-e8a3-4bac-9bf9-de45040d4fcf',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FNeck1.jpg?alt=media&token=f10e1ff9-1ea2-46e3-b251-4e640de156f8',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FQuadriceps1.jpg?alt=media&token=ebdab626-9e6b-42f8-9f18-f2c3dd285d2c',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FTraps2.jpg?alt=media&token=aa425be3-02c2-47ca-be46-7cba3e5f57f2',
    'https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Muscles%2FTriceps2.jpg?alt=media&token=51a8d7bc-669c-4a26-b1a6-bab164730675'
  ];
  List YogaImages=[
    "https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Yoga%20Images%2FCore%20Yoga.jpg?alt=media&token=e65b1961-2838-42b3-9520-6b7e4ba3be0b",
    "https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Yoga%20Images%2FSeated%20Yoga.jpg?alt=media&token=88c7ee0d-b8a6-42b8-8762-042241febb75",
    "https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Yoga%20Images%2FStrengthening%20Yoga.jpg?alt=media&token=6ca55675-3927-46e3-9800-5d035aaf171e",
    "https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Yoga%20Images%2FChest%20Opening%20Yoga.jpg?alt=media&token=0548b001-b414-4635-a6cc-b0978a0b24ba",
    "https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Yoga%20Images%2FBackbend%20Yoga.jpg?alt=media&token=ac3d7476-3ce1-4a7e-99e7-c2a66c3a1b8b",
    "https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Yoga%20Images%2FForward%20Bend%20Yoga.jpg?alt=media&token=039b0555-f6d5-4353-ab69-41bd09d59692",
    "https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Yoga%20Images%2FHip%20Opening%20Yoga.jpg?alt=media&token=135d9b8e-5869-489e-8b84-d6fa6c937d8d",
    "https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Yoga%20Images%2FStanding%20Yoga.jpg?alt=media&token=cb4c2e58-96f9-415a-9197-e68b51ac6399",
    "https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Yoga%20Images%2FRestorative%20Yoga.jpg?alt=media&token=5436a6cd-2dfd-40fc-b216-8e1ab7cbc19a",
    "https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Yoga%20Images%2FArm%20Balance%20Yoga.jpg?alt=media&token=14239c79-579e-4f32-bca9-a4ee8612f2c2",
    "https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Yoga%20Images%2FBalancing%20Yoga.jpg?alt=media&token=2fc3c2d7-0b60-42d6-800f-179fcdcc9fd9",
    "https://firebasestorage.googleapis.com/v0/b/fitnexx-4896f.appspot.com/o/Yoga%20Images%2FInversion%20Yoga.jpg?alt=media&token=5c154f3c-c694-4fac-9e18-4551b4529864",
  ];
}